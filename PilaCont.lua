local Stack = require("Stack")
local Contenedor = require("Contenedor")

local PilaCont = {}
function PilaCont:Create(pila_long)
  local objeto = Stack:Create()

  for _ = 1, pila_long do
    objeto:push(Contenedor:Create())
  end

  function objeto:obtener_pila(num_esperado)
    -- se cuenta desde abajo hasta arriba
    local pila_aux = Stack:Create()
    local codigos = {}

    for _ = 1, objeto:size() do
      local cont_sacado = objeto:peek()
      objeto:pop()

      pila_aux:push(cont_sacado)
    end

    for i = 1, pila_aux:size() do
      local cont_sacado = pila_aux:peek()
      codigos[i] = cont_sacado.codigo
      pila_aux:pop()

      objeto:push(cont_sacado)
    end

    for i = 1, num_esperado - objeto:size() do
      codigos[objeto:size() + i] = "vacio"
    end

    return codigos
  end

  function objeto:sacar_contenedor(codigo_buscar)
    objeto.codigo_buscar = codigo_buscar
    local contenedor = objeto:sacar(self, Stack:Create())

    return contenedor, objeto.posicion
  end

  function objeto:sacar(pila, pila_aux)
    local contenedor = nil
    if pila:size() > 0 then
      local cont_sacado = pila:peek()
      pila:pop()

      if cont_sacado.codigo ~= objeto.codigo_buscar then
        pila_aux:push(cont_sacado)
        contenedor = objeto:sacar(pila, pila_aux)

        cont_sacado = pila_aux:peek()
        pila_aux:pop()
        pila:push(cont_sacado)
      else
        contenedor = cont_sacado
        objeto.posicion = pila:size() + 1
      end
    end

    return contenedor
  end

  return objeto
end

return PilaCont
