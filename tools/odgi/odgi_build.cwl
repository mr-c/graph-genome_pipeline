#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: odgi build
doc: construct a dynamic succinct variation graph

requirements:
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.graph)
        writable: true

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/odgi:0.3--py37h8b12597_0

inputs:
  graph:
    type: File
    inputBinding:
      prefix: --gfa=
      separate: false
      valueFrom: $(self.basename)
    #format: GFA

arguments:
  - --progress
  - prefix: --out=
    valueFrom: $(inputs.graph.nameroot).og
    separate: false

baseCommand: [ odgi, build ]

outputs:
  sparse_graph_index:
    type: File
    outputBinding:
      glob: $(inputs.graph.nameroot).og  
