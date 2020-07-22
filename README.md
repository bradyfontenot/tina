# Tina - Work in Progress. still under development

[Project Board](https://github.com/users/bradyfontenot/projects/4)

**TODO: Add description**
- [ ] Write mock tests
- [ ] Review error handling
- [ ] Finish Documentation
- [ ] Publish to Hex

**ALPHA STAGE**
This is an early version of an elixir api wrapper for Alpaca Markets. I suggest
using it extensively in a paper trading environment before trusting it for live
trading.  At this point it has not been stress tested.

Implements all endpoints, alpaca streaming data, and polygon data(wip).
As time passes I would like to introduce add'l calls for the most common types of requests 
like specific order types to minimize function arity and make it more user friendly.

Successful requests are returned as follows: \
`{:ok, %Struct{}}`

Errors are return in one of the following formats: \
`{:error, %{status: status, msg: msg}}` \
`{:error, reason}`

**Alpaca API Docs**
[https://alpaca.markets/docs/api-documentation/](https://alpaca.markets/docs/api-documentation/)
 

## Installation
If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tina` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tina, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tina](https://hexdocs.pm/tina).
