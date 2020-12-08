cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: "python:latest"
  ResourceRequirement:
    coresMin: 1
    ramMin: 3000
inputs:
  readsFA:
    type: File
    inputBinding: {position: 2}
  script:
    type: File
    inputBinding: {position: 1}
    default:
      class: File
      contents:
        $include: sort_fasta_by_quality_and_len.py
stdout: $(inputs.readsFA.nameroot).sorted_by_quality_and_len.fasta
outputs:
  sortedReadsFA:
    type: File
    outputBinding:
      glob: $(inputs.readsFA.nameroot).sorted_by_quality_and_len.fasta
  dups:
    type: File
    outputBinding: {glob: dups.txt}
requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
baseCommand: [python]
