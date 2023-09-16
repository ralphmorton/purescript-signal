module Signal.Channel
  ( channel
  , send
  , update
  , subscribe
  , Channel
  ) where


import Effect (Effect)
import Prelude (Unit)

import Signal (constant, Signal)

foreign import data Channel :: Type -> Type

foreign import channelP :: forall a c. (c -> Signal c) -> a -> Effect (Channel a)

-- |Creates a channel, which allows you to feed arbitrary values into a signal.
channel :: forall a. a -> Effect (Channel a)
channel = channelP constant

foreign import sendP :: forall a. (Channel a) -> a -> Effect Unit

-- |Sends a value to a given channel.
send :: forall a. Channel a -> a -> Effect Unit
send = sendP

foreign import updateP :: forall a. (Channel a) -> (a -> a) -> Effect Unit

-- |Updates a value in a given channel.
update :: forall a. Channel a -> (a -> a) -> Effect Unit
update = updateP

-- |Takes a channel and returns a signal of the values sent to it.
foreign import subscribe :: forall a. Channel a -> Signal a
