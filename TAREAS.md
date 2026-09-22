# Tareas

* [x] 1. Definir el tipo `Curso`, que contiene:

  * `(Int) codigo`
  * `(String) nombre`
  * `(Int) cupo máximo`
  * `(Int) cantidad de inscritos`

* [x] 2-1. Completar la función:

  ```haskell
  conCupo :: [Curso] -> [Curso]
  ```

* [ ] 2-2. Completar la función:

  ```haskell
  buscarCurso :: Int -> Arbol Curso -> Maybe Curso
  ```

  * [x] Utilizar `data Arbol a = Vacio | Nodo a (Arbol a) (Arbol a) deriving Show`
  * [x] Utilizar `Maybe Curso`
  * [ ] Mantener el árbol ordenado por `codigo`
> Consgina con duda, debemos escribir funciones para ordenarlo?
  * [x] Realizar una búsqueda binaria


* [x] 2-3. Completar la función:

  ```haskell
  totalInscriptos :: [Curso] -> Int
  ```

  * [x] Resolver utilizando `foldr`

* [ ] 2-4. Completar la función:

  ```haskell
  inscribir :: Int -> [Curso] -> Either String [Curso]
  ```

  * [x] Distinguir curso inexistente
  * [x] Distinguir curso sin cupo
  * [x] Actualizar la cantidad de inscritos si hay cupo

* [ ] 2-5. Implementar:

  ```haskell
  foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b
  ```

  * [ ] Calcular la cantidad de cursos
  * [ ] Calcular el total de inscritos

* [ ] 2-6. Determinar mediante `foldArbol` si todos los cursos tienen lugares disponibles.
