Stack = {}

function Stack:Create()
  local tabla = {}
  tabla._tablaEntrada = {}

  function tabla:peek()
    return self._tablaEntrada[#self._tablaEntrada]
  end

  function tabla:isEmpty()
    return #self._tablaEntrada == 0
  end

  function tabla:size()
    return #self._tablaEntrada
  end

  function tabla:push(...)
    if ... then
      local args = { ... }
      for _, v in ipairs(args) do
        table.insert(self._tablaEntrada, v)
      end
    end
  end

  function tabla:pop()
    if #self._tablaEntrada >= 1 then
      table.remove(self._tablaEntrada, #self._tablaEntrada)
    end
  end

  return tabla
end

return Stack
