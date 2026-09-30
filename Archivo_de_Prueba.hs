module LabHaskellExtra where

import LabHaskell

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

listaCursosGrande :: [Curso]
listaCursosGrande =
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

arbolCursosGrande :: Arbol Curso
arbolCursosGrande =
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
