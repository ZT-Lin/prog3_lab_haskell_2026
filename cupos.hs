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
    |cupo >= inscrito = Curso a b cupo inscrito : conCupo xs
    | otherwise = conCupo xs


{- Ejercicio 2-2 -}
data Arbol a = Vacio | Nodo a (Arbol a) (Arbol a) deriving Show

buscarCurso :: Int -> Arbol Curso -> Maybe Curso
buscarCurso _ Vacio = Nothing
buscarCurso x (Nodo (Curso codigo b c d) izq der)
    | x ==codigo = Just (Curso codigo b c d) 
    | x > codigo = buscarCurso x izq
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

{- No entiendo xq hay un error -}
{- preguntar al profe miercoles o viernes -}



foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b
foldArbol = 
