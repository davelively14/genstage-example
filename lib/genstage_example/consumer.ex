defmodule GenstageExample.Consumer do
  use GenStage

  #######
  # API #
  #######

  def start_link do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  #############
  # Callbacks #
  #############

  def init(state) do
    {:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect({self(), event, state})
    end

    # Never emit events (second element) as a :consumer
    {:noreply, [], state}
  end
end
