{- === DATOS DE PRUEBA EXTRA: LISTA GRANDE === -}

cursoHaskell   = Curso  5 "Haskell"   25 10
cursoPython    = Curso 15 "Python"    35 35   -- lleno
cursoC         = Curso 25 "C"         50 20
cursoRuby      = Curso 35 "Ruby"      30 30   -- lleno
cursoSwift     = Curso 45 "Swift"     20  5
cursoKotlin    = Curso 55 "Kotlin"    40 39   -- queda 1 lugar
cursoRust      = Curso 65 "Rust"      15 15   -- lleno
cursoGo        = Curso 75 "Go"        60 45
cursoScala     = Curso 85 "Scala"     10  0
cursoErlang    = Curso 95 "Erlang"    12 12   -- lleno

listaCursos :: [Curso]
listaCursos =
    [ cursoHaskell
    , cursoPython
    , cursoC
    , cursoRuby
    , cursoSwift
    , cursoKotlin
    , cursoRust
    , cursoGo
    , cursoScala
    , cursoErlang
    ]

{- === DATOS DE PRUEBA EXTRA: ÁRBOL GRANDE === -}

arbolCursos :: Arbol Curso
arbolCursos =
    Nodo cursoC
      (Nodo cursoHaskell
        (Nodo cursoPython Vacio Vacio)
        (Nodo cursoRuby Vacio Vacio))
      (Nodo cursoGo
        (Nodo cursoKotlin
          (Nodo cursoSwift Vacio Vacio)
          (Nodo cursoRust Vacio Vacio))
        (Nodo cursoErlang
          (Nodo cursoScala Vacio Vacio)
          Vacio))

{- === PRUEBAS: CASOS NORMALES === -}

-- 1. conCupo: Debería devolver solo las courses con cupo > inscrito:
--    Haskell(10/25), C(20/50), Swift(5/20), Kotlin(39/40), Go(45/60), Scala(0/10)
pruebaConCupoNormal = conCupo listaCursos

-- 2. buscarCurso: Debería devolver Just (Curso 35 "Ruby" 30 30)
pruebaBuscarNormal = buscarCurso 35 arbolCursos

-- 3. totalInscriptos: Debería sumar 211
pruebaTotalInscriptos = totalInscriptos listaCursos

-- 4. inscribir: Debería devolver Right con la lista completa, sumando 1 inscripto a Haskell
--    (Haskell pasa de 10 a 11)
pruebaInscribirNormal = inscribir 5 listaCursos

-- 5. calcular: Debería devolver (10, 211) recorriendo todo el árbol
pruebaCalcularArbol = calcular arbolCursos


{- === PRUEBAS: CASOS LÍMITE Y DE ERROR === -}

-- 6. inscribir (Sin Cupo): Intenta inscribir en Python que tiene 35/35.
--    Debería devolver Left "Sin cupo".
pruebaInscribirLleno = inscribir 15 listaCursos

-- 7. inscribir (Inexistente): Intenta inscribir en un código que no existe.
--    Debería devolver Left "Inexistente".
pruebaInscribirInexistente = inscribir 99 listaCursos

-- 8. inscribir (Borde exacto): Inscribe en Kotlin, que está en 39/40.
--    Debería dejarlo en 40/40. Prueba que la condición (cupo > inscrito)
--    funciona justo en el límite.
pruebaInscribirUltimoLugar = inscribir 55 listaCursos

-- 9. buscarCurso (Árbol Vacío): Límite estructural.
--    Buscar en un árbol sin inicializar debe dar Nothing.
pruebaBuscarVacio = buscarCurso 10 Vacio

-- 10. inscribir (Lista Vacía): Límite estructural.
--     Intentar inscribir en una base de datos vacía debe dar Left "Inexistente".
pruebaInscribirVacio = inscribir 10 []

-- 11. disponible: Devuelve False porque hay varios cursos llenos
--     (Python, Ruby, Rust, Erlang), y el fold exige que TODOS tengan cupo.
pruebaDisponibleLimite = disponible arbolCursos

{- ==================================================================================== -}

{- Ejercicio 1 -}
type Codigo = Int
type Nombre = String
type Cupo = Int
type Inscrito = Int
data Curso = Curso Codigo Nombre Cupo Inscrito deriving Show

{- Ejercicio 2-1 -}
conCupo :: [Curso] -> [Curso]
conCupo [] = []
conCupo (Curso a b cupo inscrito:xs)
    |cupo > inscrito = Curso a b cupo inscrito : conCupo xs
    | otherwise = conCupo xs


{- Ejercicio 2-2 -}
data Arbol a = Vacio | Nodo a (Arbol a) (Arbol a) deriving Show

buscarCurso :: Int -> Arbol Curso -> Maybe Curso
buscarCurso _ Vacio = Nothing
buscarCurso x (Nodo (Curso codigo b c d) izq der)
    | x == codigo = Just (Curso codigo b c d) 
    | x < codigo = buscarCurso x izq
    | otherwise  = buscarCurso x der

{- Ejercicio 2-3 -}
totalInscriptos :: [Curso] -> Int
totalInscriptos = foldr (\ (Curso _ _ _ inscrito) x -> inscrito + x) 0

{- Ejercicio 2-4 -}
inscribir :: Int -> [Curso] -> Either String [Curso]
inscribir code cursos = accumular code cursos []

{- funcion auxiliar -}
accumular :: Codigo -> [Curso] -> [Curso] -> Either String [Curso]
accumular _ [] _ = Left "Inexistente"
accumular code ((Curso codigo b cupo inscrito):xs) acc
    | (code == codigo) && (cupo > inscrito) = Right ((reverse acc) ++ (Curso codigo b cupo (inscrito+1):xs))
    | (code == codigo) && (cupo <= inscrito) = Left "Sin Cupo"
    | otherwise = accumular code xs ((Curso codigo b cupo inscrito):acc)

{- Ejercicio 2-5 -}
foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b
foldArbol _ acc Vacio = acc
foldArbol f acc (Nodo v i d) = f v (foldArbol f acc i) (foldArbol f acc d) 

{- funcion auxiliar -}
contar :: Curso -> (Int,Inscrito) -> (Int, Inscrito)-> (Int,Inscrito)
contar (Curso _ _ _ inscrito) (a,b) (c,d) = (a+c+1, b+d+inscrito)

{- implementacion con foldArbol -}
calcular :: Arbol Curso -> (Int, Inscrito)
calcular = foldArbol contar (0,0)

{- Ejercicio 2-6 -}
{- funcion auxiliar -}
lugarDisponible :: Curso -> Bool -> Bool -> Bool
lugarDisponible (Curso _ _ cupo inscrito) i d 
    | cupo > inscrito = True && i && d
    | otherwise = False && i && d

{- implementacion con foldArbol -}
disponible :: Arbol Curso -> Bool
disponible = foldArbol lugarDisponible True
