defmodule Example do
  require Logger

  defmacro __using__(_) do
    quote do
      def start_link(args \\ []) do
        Example.start_link(args, {__MODULE__, :process})
      end

      def child_spec(args \\ []) do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, args},
          type: :worker
        }
      end
    end
  end

  def start_link(args, mf) do
    args = Keyword.put(args, :process, mf)
    GenServer.start_link(__MODULE__, args)
  end

  def init(data) do
    Logger.info("Starting GenServer with state: #{inspect(data)}")
    {:ok, data}
  end

  def handle_info(event, state) do
    {module, function} = state[:process]
    apply(module, function, [event])
    {:noreply, state}
  end
end
