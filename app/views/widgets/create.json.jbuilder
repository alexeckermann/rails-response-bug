json.set! :success, success
if success
  json.path widget_path(widget)
  json.widget do
    json.partial! "widgets/widget", widget: widget
  end
else
  json.errors widget.errors.to_a
end