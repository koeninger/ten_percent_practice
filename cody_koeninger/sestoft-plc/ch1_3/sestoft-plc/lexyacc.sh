#!/bin/bash

fslex --unicode ExprLex.fsl
fsyacc --module ExprPar ExprPar.fsy
fsharpi -r /Users/cody/fsharp//FsLexYacc.Runtime.7.0.6/lib/portable-net45+netcore45+wpa81+wp8+MonoAndroid10+MonoTouch10/FsLexYacc.Runtime.dll \
        Absyn.fs ExprPar.fs ExprLex.fs Parse.fs
