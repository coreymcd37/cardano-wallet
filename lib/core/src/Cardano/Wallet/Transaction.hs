{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}

-- |
-- Copyright: © 2018-2020 IOHK
-- License: Apache-2.0
--
-- An extra interface for operation on transactions (e.g. creating witnesses,
-- estimating size...). This makes it possible to decouple those operations from
-- our wallet layer, keeping the implementation flexible to various backends.

module Cardano.Wallet.Transaction
    (
    -- * Interface
      TransactionLayer (..)
    , Certificate (..)

    -- * Errors
    , ErrMkTx (..)
    , ErrValidateSelection
    , ErrDecodeSignedTx (..)
    ) where

import Prelude

import Cardano.Address.Derivation
    ( XPrv )
import Cardano.Wallet.Primitive.AddressDerivation
    ( Depth (..), Passphrase )
import Cardano.Wallet.Primitive.CoinSelection
    ( CoinSelection (..) )
import Cardano.Wallet.Primitive.Fee
    ( Fee, FeePolicy )
import Cardano.Wallet.Primitive.Types
    ( Address (..)
    , PoolId
    , SealedTx (..)
    , SlotId (..)
    , Tx (..)
    , TxIn (..)
    , TxOut (..)
    , WalletDelegation
    )
import Data.ByteString
    ( ByteString )
import Data.Quantity
    ( Quantity (..) )
import Data.Text
    ( Text )
import Data.Word
    ( Word16, Word8 )

data TransactionLayer t k = TransactionLayer
    { mkStdTx
        :: (Address -> Maybe (k 'AddressK XPrv, Passphrase "encryption"))
        -> SlotId
        -> [(TxIn, TxOut)]
        -> [TxOut]
        -> Either ErrMkTx (Tx, SealedTx)
        -- ^ Construct a standard transaction
        --
        -- " Standard " here refers to the fact that we do not deal with redemption,
        -- multisignature transactions, etc.
        --
        -- This expects as a first argument a mean to compute or lookup private
        -- key corresponding to a particular address.

    , mkDelegationJoinTx
        :: FeePolicy
            -- Latest fee policy
        -> WalletDelegation
            -- Wallet current delegation status
        -> PoolId
            -- Pool Id to which we're planning to delegate
        -> (k 'AddressK XPrv, Passphrase "encryption")
            -- Reward account
        -> (Address -> Maybe (k 'AddressK XPrv, Passphrase "encryption"))
            -- Key store
        -> SlotId
            -- Tip of the chain, for TTL
        -> [(TxIn, TxOut)]
            --  Resolved inputs
        -> [TxOut]
            -- Outputs
        -> [TxOut]
            -- Change, with assigned address
        -> Either ErrMkTx (Tx, SealedTx)
        -- ^ Construct a transaction containing a certificate for delegating to
        -- a stake pool.
        --
        -- The certificate is a combination of the 'PoolId' and the public key
        -- of the reward account. (Note that this is an address key and
        -- HD account keys are something different)

    , mkDelegationQuitTx
        :: FeePolicy
            -- Latest fee policy
        -> (k 'AddressK XPrv, Passphrase "encryption")
            -- Reward account
        -> (Address -> Maybe (k 'AddressK XPrv, Passphrase "encryption"))
            -- Key store
        -> SlotId
            -- Tip of the chain, for TTL
        -> [(TxIn, TxOut)]
            -- Resolved inputs
        -> [TxOut]
            -- Outputs
        -> [TxOut]
            -- Change, with assigned address
        -> Either ErrMkTx (Tx, SealedTx)
        -- ^ Construct a transaction containing a certificate for quiting from
        -- a stake pool.
        --
        -- The certificate is the public key of the reward account.

    , minimumFee :: FeePolicy -> [Certificate] -> CoinSelection -> Fee
        -- ^ Compute a minimal fee amount necessary to pay for a given
        -- coin-selection. '[Certificate]' can be used to communicate whether
        -- or not the transaction carries (un)delegation certificates.

    , estimateMaxNumberOfInputs :: Quantity "byte" Word16 -> Word8 -> Word8
        -- ^ Calculate a "theoretical" maximum number of inputs given a maximum
        -- transaction size and desired number of outputs.
        --
        -- The actual transaction size cannot be known until it has been fully
        -- determined by coin selection.
        --
        -- This estimate will err on the side of permitting more inputs,
        -- resulting in a transaction which may be too large.

    , validateSelection
      :: CoinSelection -> Either (ErrValidateSelection t) ()
      -- ^ Validate coin selection regarding rules that may be specific to a
      -- particular backend implementation.
      --
      -- For example, Byron nodes do not allow null output amounts. Jörmungandr
      -- on its side doesn't support more than 255 inputs or outputs.

    , allowUnbalancedTx
      :: Bool
      -- ^ Whether the transaction layer accepts unbalanced transactions.

    , decodeSignedTx
        :: ByteString -> Either ErrDecodeSignedTx (Tx, SealedTx)
        -- ^ Decode an externally-signed transaction to the chain producer
    }

-- | A type family for validations that are specific to a particular backend
-- type. This demands an instantiation of the family for a particular backend:
--
--     type instance (ErrValidateSelection MyBackend) = MyCustomError
--
type family ErrValidateSelection t

-- | Error while trying to decode externally signed transaction
data ErrDecodeSignedTx
    = ErrDecodeSignedTxWrongPayload Text
    | ErrDecodeSignedTxNotSupported
    deriving (Show, Eq)

-- | Possible signing error
data ErrMkTx
    = ErrKeyNotFoundForAddress Address
    -- ^ We tried to sign a transaction with inputs that are unknown to us?
    | ErrChangeIsEmptyForRetirement
    -- ^ When retiring on Shelley, we need to add a deposit amount made when
    -- creating a stake key. This requires at least one change output, which
    -- ought to be present anyway by construction of the coin selection when
    -- quitting delegation.
    deriving (Eq, Show)

data Certificate
    = PoolDelegationCertificate
    | KeyRegistrationCertificate
    | KeyDeRegistrationCertificate
    deriving (Eq, Show)