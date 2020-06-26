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
    , WithDelegation (..)

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
        :: WalletDelegation
        -> PoolId
        -> (k 'AddressK XPrv, Passphrase "encryption") -- reward account
        -> (Address -> Maybe (k 'AddressK XPrv, Passphrase "encryption"))
        -> SlotId
        -> [(TxIn, TxOut)]
        -> [TxOut]
        -> Either ErrMkTx (Tx, SealedTx)
        -- ^ Construct a transaction containing a certificate for delegating to
        -- a stake pool.
        --
        -- The certificate is a combination of the 'PoolId' and the public key
        -- of the reward account. (Note that this is an address key and
        -- HD account keys are something different)

    , mkDelegationQuitTx
        :: (k 'AddressK XPrv, Passphrase "encryption") -- reward account
        -> (Address -> Maybe (k 'AddressK XPrv, Passphrase "encryption"))
        -> SlotId
        -> [(TxIn, TxOut)]
        -> [TxOut]
        -> Either ErrMkTx (Tx, SealedTx)
        -- ^ Construct a transaction containing a certificate for quiting from
        -- a stake pool.
        --
        -- The certificate is the public key of the reward account.

    , minimumFee :: FeePolicy -> WithDelegation -> CoinSelection -> Fee
        -- ^ Compute a minimal fee amount necessary to pay for a given
        -- coin-selection. 'WithDelegation' can be used to communicate whether
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
newtype ErrMkTx
    = ErrKeyNotFoundForAddress Address
    -- ^ We tried to sign a transaction with inputs that are unknown to us?
    deriving (Eq, Show)

newtype WithDelegation
    = WithDelegation Bool
    deriving (Eq, Show)