#prog3_lab_haskell_2026

## ejercicios del laboratorio

1. Defina el tipo `Curso` para representar código, nombre, cupo máximo y cantidad de inscritos.
2. Implemente las funciones que se describen a continuación.
   1. `conCupo :: [Curso] -> [Curso]`
   2. `buscarCurso :: Int -> Arbol Curso -> Maybe Curso` que retorna un curso si lo encuentra.
      1. Utilizar `data Arbol a = Vacio | Nodo a (Arbol a) (Arbol a) deriving Show`.
      2. El árbol se debe encontrar ordenado por Codigo y la función realizar una búsquedabinaria.
   3. `totalInscriptos :: [Curso] -> Int` la cual debe resolverse con `foldr`.
   4. `inscribir :: Int -> [Curso] -> Either String [Curso]`, la cual debe distinguir curso inexistente y curso sin cupo.
   5. Sobre `Arbol Curso` calcular la cantidad de cursos y el total de inscritos usando `foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b`.
   6. Determinar mediante `foldArbol` si todos los cursos tienen lugares disponibles.

# integrante

- Lin Franco
- Agustin
