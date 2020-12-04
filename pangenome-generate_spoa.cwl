#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
inputs:
  seqs: File
outputs:
  odgiGraph:
    type: File
    outputSource: buildGraph/odgiGraph
  odgiPNG:
   type: File
   outputSource: vizGraph/graph_image
  spoaGFA:
    type: File
    outputSource: induceGraph/spoaGFA
  readsMergeDedupSortedByQualAndLen:
    type: File
    outputSource: dedup_and_sort_by_quality_and_len/sortedReadsFA
steps:
  dedup_and_sort_by_quality_and_len:
    in: {readsFA: seqs}
    out: [sortedReadsFA, dups]
    run: tools/sort_fasta_by_quality_and_len/sort_fasta_by_quality_and_len.cwl
  induceGraph:
    in:
      readsFA: dedup_and_sort_by_quality_and_len/sortedReadsFA
    out: [spoaGFA]
    run: tools/spoa/spoa.cwl
  buildGraph:
    in: {inputGFA: induceGraph/spoaGFA}
    out: [odgiGraph]
    run: tools/odgi/odgi-build-from-spoa-gfa.cwl
  vizGraph:
    in:
      sparse_graph_index: buildGraph/odgiGraph
      width:
        default: 1400
      height:
        default: 400
      path_height:
        default: 4
    out: [graph_image]
    requirements:
      ResourceRequirement:
        ramMin: $(7 * 1024)
        outdirMin: 10
    run: tools/odgi/odgi_viz.cwl
