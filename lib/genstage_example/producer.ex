defmodule GenstageExample.Producer do
  use GenStage

  #######
  # API #
  #######

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  #############
  # Callbacks #
  #############

  # Label ourselves as a producer via the response
  def init(counter), do: {:producer, counter}

  # This function mst be implemented by all GenStage producers. The demand from
  # consumers is represented as an integer correspoding to the number of events
  # they can handle. Defaults to 1000.
  def handle_demand(demand, state) do
    events = Enum.to_list(state..(state + demand - 1))

    {:noreply, events, state + demand}
  end
end
