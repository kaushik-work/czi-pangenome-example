cwlVersion: v1.0
class: CommandLineTool
inputs:
  readsFA: File
outputs:
  spoaGFA:
    type: File
    outputBinding: {glob: $(inputs.readsFA.nameroot).g6.gfa}

requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerPull: "quay.io/biocontainers/spoa:3.4.0--hc9558a2_0"
  ResourceRequirement:
    coresMin: 1
    ramMin: $(15 * 1024)
    outdirMin: $(Math.ceil(inputs.readsFA.size/(1024*1024*1024) + 20))
baseCommand: spoa
stdout: $(inputs.readsFA.nameroot).g6.gfa
arguments: [
    $(inputs.readsFA),
    -G,
    -g, '-6'
]
