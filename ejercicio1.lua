local PilaCont = require("PilaCont")

local bodega = {}
local pila_long = 8
local fila_long = 7
local filas = 9

local function llenar_bodega()
  for i = 1, filas do
    local fila = {}
    for j = 1, fila_long do
      fila[j] = PilaCont:Create(pila_long)
    end
    bodega[i] = fila
  end
end

local posicion = { fila = -1, columna = -1, pila = -1 }
local codigo_buscar
local function sacar_contenedor(pilas_n, filas_n)
  local contenedor = nil
  if filas_n <= filas then
    if pilas_n <= fila_long then
      local pila = bodega[filas_n][pilas_n]
      local cont_busqueda, pila_pos = pila:sacar_contenedor(codigo_buscar)

      if cont_busqueda == nil then
        contenedor = sacar_contenedor(pilas_n + 1, filas_n)
      else
        contenedor = cont_busqueda
        posicion.fila = filas_n
        posicion.columna = pilas_n
        posicion.pila = pila_pos
      end
    else
      pilas_n = 1
      filas_n = filas_n + 1
      contenedor = sacar_contenedor(pilas_n, filas_n)
    end
  end

  return contenedor
end

local function mostrar_bodega()
  for i = 1, filas do
    local fila = bodega[i]
    local pilas = {}

    for j = 1, fila_long do
      local pila = fila[j]:obtener_pila(pila_long)
      pilas[j] = pila
    end

    print(i)
    for k = pila_long, 1, -1 do
      for j = 1, fila_long do
        io.write(pilas[j][k] .. "  ")
      end
      print()
    end
    print("-----------------------------------------------")
  end
end

local opcion
local function imprimir_menu()
  print("0. Salir")
  print("1. Llenar bodega")
  print("2. Mostrar bodega")
  print("3. Sacar contenedor")
end

repeat
  imprimir_menu()
  io.write("> ")
  opcion = tonumber(io.read())

  if opcion == 1 then
    llenar_bodega()
  elseif opcion == 2 then
    mostrar_bodega()
  elseif opcion == 3 then
    io.write(">> ")
    codigo_buscar = io.read()
    local contenedor = sacar_contenedor(1, 1)
    local codigo

    if contenedor ~= nil then
      codigo = contenedor.codigo
    end

    print("Contenedor sacado: ", codigo)
    print("Fila: ", posicion.fila)
    print("Columna: ", posicion.columna)
    print("Pila posicion: ", posicion.pila)
  end
until opcion == 0
