# Tareas

* [ ] 1. Definir el tipo `Curso`, que contiene:

  * `(Int) codigo`
  * `(String) nombre`
  * `(Int) cupo máximo`
  * `(Int) cantidad de inscritos`

* [ ] 2. Completar la función:

  ```haskell
  conCupo :: [Curso] -> [Curso]
  ```

* [ ] 3. Completar la función:

  ```haskell
  buscarCurso :: Int -> Arbol Curso -> Maybe Curso
  ```

  * [ ] Utilizar `Arbol`
  * [ ] Utilizar `Maybe Curso`
  * [ ] Mantener el árbol ordenado por `codigo`
  * [ ] Realizar una búsqueda binaria


* [ ] 4. Completar la función:

  ```haskell
  totalInscriptos :: [Curso] -> Int
  ```

  * [ ] Resolver utilizando `foldr`

* [ ] 5. Completar la función:

  ```haskell
  inscribir :: Int -> [Curso] -> Either String [Curso]
  ```

  * [ ] Distinguir curso inexistente
  * [ ] Distinguir curso sin cupo
  * [ ] Actualizar la cantidad de inscritos si hay cupo

* [ ] 6. Implementar:

  ```haskell
  foldArbol :: (a -> b -> b -> b) -> b -> Arbol a -> b
  ```

  * [ ] Calcular la cantidad de cursos
  * [ ] Calcular el total de inscritos

* [ ] 7. Determinar mediante `foldArbol` si todos los cursos tienen lugares disponibles.
