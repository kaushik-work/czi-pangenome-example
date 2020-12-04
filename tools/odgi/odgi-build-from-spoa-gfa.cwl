cwlVersion: v1.0
class: CommandLineTool
inputs:
  inputGFA: File
outputs:
  odgiGraph:
    type: File
    outputBinding:
      glob: $(inputs.inputGFA.nameroot).unchop.sorted.odgi
requirements:
  InlineJavascriptRequirement: {}
hints:
  DockerRequirement:
    dockerImageId: odgi:2020-12-01
    dockerFile: {$include: odgi-dockerfile}
  ResourceRequirement:
    coresMin: 1
    ramMin: $(7 * 1024)
    outdirMin: $(Math.ceil((inputs.inputGFA.size/(1024*1024*1024)+1) * 2))
  InitialWorkDirRequirement:
    # Will fail if input file is not writable (odgi bug)
    listing:
      - entry: $(inputs.inputGFA)
        writable: true
  ShellCommandRequirement: {}
arguments:
  - shellQuote: false
    valueFrom: >-
      odgi build -g '$(inputs.inputGFA.path)' -o - | odgi unchop -i - -o - |
      odgi sort -i - -p s -o $(inputs.inputGFA.nameroot).unchop.sorted.odgi
