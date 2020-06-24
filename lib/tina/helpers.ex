defmodule Tina.Helpers do
  def to_struct(map, struct) do
    map_with_atom_keys =
      for {k, v} <- map, into: %{} do
        {String.to_existing_atom(k), v}
      end

    struct(struct, map_with_atom_keys)
  end
end
