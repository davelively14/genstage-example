defmodule GenstageExample.ProducerConsumer do
  use GenStage

  require Integer

  #######
  # API #
  #######

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  #############
  # Callbacks #
  #############

  def init(state) do
    # subscribe_to instructs GenStage to put us in communication with a producer
    {:producer_consumer, state, subscribe_to: [GenstageExample.Producer]}
  end

  # Receives incoming events, processes them, and returns a transformed set.
  def handle_events(events, _from, state) do
    numbers =
      events
      |> Enum.filter(&Integer.is_even/1)

    # The second argument, numbers, has to meet the demand of consumers
    # downstream. In consumers, this value is just discarded.
    {:noreply, numbers, state}
  end
end
