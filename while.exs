defmodule Loop do
  defmacro while(expression, do: code_block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expression) do
            unquote(code_block)
          else
            throw(:break)
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break(), do: throw(:break)
end
