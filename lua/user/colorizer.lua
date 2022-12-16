local status_ok, _ = pcall(require, "colorizer")
if not status_ok then
  return
end

require("colorizer").setup()
