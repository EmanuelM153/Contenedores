math.randomseed(os.time())

Contenedor = { codigo_inicio = 1111 }
function Contenedor:Create()
  local objeto = {}
  local codigo = string.char(math.random(97, 122))
  codigo = codigo .. tostring(self.codigo_inicio)

  self.codigo_inicio = self.codigo_inicio + 1

  objeto.codigo = codigo
  return objeto
end

return Contenedor
