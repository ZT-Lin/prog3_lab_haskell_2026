{- === DATOS DE PRUEBA === -}
cursoMIPS   = Curso 10 "MIPS" 30 15     -- Caso Normal: A la mitad de capacidad
cursoJava   = Curso 20 "Java" 40 40     -- Caso Límite: Totalmente lleno 
cursoProlog = Curso 30 "Prolog" 20 19   -- Caso Límite: Queda exactamente 1 lugar

listaCursos :: [Curso]
listaCursos = [cursoMIPS, cursoJava, cursoProlog]

-- Árbol ordenado por código (20 en la raíz, 10 a la izq, 30 a la der)
arbolCursos :: Arbol Curso
arbolCursos = Nodo cursoJava (Nodo cursoMIPS Vacio Vacio) (Nodo cursoProlog Vacio Vacio)


{- === PRUEBAS: CASOS NORMALES === -}

-- 1. conCupo: Debería devolver la lista solo con MIPS y Prolog
pruebaConCupoNormal = conCupo listaCursos

-- 2. buscarCurso: Debería devolver Just (Curso 30 "Prolog" 20 19)
pruebaBuscarNormal = buscarCurso 30 arbolCursos

-- 3. totalInscriptos: Debería sumar 15 + 40 + 19 = 74
pruebaTotalInscriptos = totalInscriptos listaCursos

-- 4. inscribir: Debería devolver Right con la lista completa, sumando 1 inscripto a MIPS
pruebaInscribirNormal = inscribir 10 listaCursos

-- 5. calcular: Debería devolver (3, 74) recorriendo todo el árbol
pruebaCalcularArbol = calcular arbolCursos


{- === PRUEBAS: CASOS LÍMITE Y DE ERROR === -}

-- 6. inscribir (Sin Cupo): Intenta inscribir en Java que tiene 40/40. Debería devolver Left "Sin cupo".
pruebaInscribirLleno = inscribir 20 listaCursos

-- 7. inscribir (Inexistente): Intenta inscribir en un código que no existe. Debería devolver Left "Inexistente".
pruebaInscribirInexistente = inscribir 99 listaCursos

-- 8. inscribir (Borde exacto): Inscribe en Prolog, dejándolo en 20/20. Prueba que tu condición (cupo > inscrito) funciona justo en el límite.
pruebaInscribirUltimoLugar = inscribir 30 listaCursos

-- 9. buscarCurso (Árbol Vacío): Límite estructural. Buscar en un árbol sin inicializar debe dar Nothing.
pruebaBuscarVacio = buscarCurso 10 Vacio

-- 10. inscribir (Lista Vacía): Límite estructural. Intentar inscribir en una base de datos vacía debe dar Left "Inexistente".
pruebaInscribirVacio = inscribir 10 []

-- 11. disponible: Devuelve False porque la presencia de un solo curso lleno (Java) debe invalidar todo el árbol mediante el fold.
pruebaDisponibleLimite = disponible arbolCursos




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
inscribir _ [] = Left "Inexistente"
inscribir code ((Curso codigo b cupo inscrito):xs)
    | (code == codigo) && (cupo > inscrito) = Right ( (Curso codigo b cupo (inscrito+1) ) :xs )
    | (code == codigo) && (cupo <= inscrito) = Left "Sin cupo"
    | otherwise = inscribir code xs

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