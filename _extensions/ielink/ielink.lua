function ieLink(args)
  -- Join all path parts with "/" to build the relative path
  local path = table.concat(args, "/")

  -- GitHub URL pointing to the readable "blob" view
  local url = "https://github.com/iset/ISETCam/blob/main/" .. path

  -- Use the filename (last part) as link text
  local filename = args[#args]

  return pandoc.RawInline('html',
    string.format('<a href="%s" target="_blank">%s</a>', url, filename)
  )
end
