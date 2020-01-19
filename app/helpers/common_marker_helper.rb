module CommonMarkerHelper
  def markdown2html(mdtext)
    CommonMarker.render_html(mdtext)
  end
end
