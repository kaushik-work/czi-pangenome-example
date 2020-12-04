#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: odgi viz
doc: variation graph visualizations

requirements:
  InlineJavascriptRequirement: {}
hints:
  SoftwareRequirement:
    packages:
      odgi:
        version: [ "0.4.1" ]
  ResourceRequirement:
    coresMin: 1
    ramMin: $(7 * 1024)
    outdirMin: 1
  DockerRequirement:
    dockerImageId: odgi:2020-12-01
    dockerFile: {$include: odgi-dockerfile}
inputs:
  sparse_graph_index: File
  width:
    type: int?
    doc: width in pixels of output image
    inputBinding:
      prefix: --width=
      separate: false
  height:
    type: int?
    doc: height in pixels of output image
    inputBinding:
      prefix: --height=
      separate: false
  path_height:
    type: int?
    doc: path display height
    inputBinding:
      prefix: --path-height=
      separate: false

arguments:
  - --idx=$(inputs.sparse_graph_index.path)
  - --out=$(inputs.sparse_graph_index.nameroot).png

baseCommand: [ odgi, viz ]

outputs:
  graph_image:
    type: File
    format: iana:image/png
    outputBinding:
      glob: $(inputs.sparse_graph_index.nameroot).png

$namespaces:
  iana: https://www.iana.org/assignments/media-types/
