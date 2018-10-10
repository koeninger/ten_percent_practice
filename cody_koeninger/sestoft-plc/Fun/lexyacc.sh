#!/bin/bash

fslex --unicode FunLex.fsl
fsyacc --module FunPar FunPar.fsy
fsharpi -r /Users/cody/fsharp//FsLexYacc.Runtime.7.0.6/lib/portable-net45+netcore45+wpa81+wp8+MonoAndroid10+MonoTouch10/FsLexYacc.Runtime.dll \
        Absyn.fs FunPar.fs FunLex.fs Parse.fs Fun.fs ParseAndRun.fs
