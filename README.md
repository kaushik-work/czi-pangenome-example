Demo CWL workflow

Generate graph genome (with visualization) from a set of sequences using `spoa` and `odgi`.

Sample data set of 100 SARS-CoV-2 viral genomes, from [PubSeq](http://covid-19.genenetwork.org/)

```
cwl-runner pangenome-generate_spoa.cwl pubseq.yml
```

Interoperability demo

|Software|Result|
|--------|-----------|
|cwltool|success|
|Arvados|success|
