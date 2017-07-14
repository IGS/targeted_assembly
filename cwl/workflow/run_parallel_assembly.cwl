#!/usr/bin/env cwl-runner
cwlVersion: v1.0
label: Targeted Assembly -- run parallel assembly (SPAdes, HGA, ScaffoldBuilder)
class: CommandLineTool


requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: LD_LIBRARY_PATH
        envValue: $(inputs.python3_lib)

inputs:
  reads_dir:
    label: Reads directory made by build_workspace.cwl
    type: Directory?
    inputBinding:
      prefix: "--reads_dir"

  assmb_path:
    label: Path to the the directory to initialize directories for all the assembly output
    type: Directory
    inputBinding:
      prefix: "--assmb_path"

  assmb_map:
    label: Path to map from format_for_assembly.cwl
    type: File
    inputBinding:
      prefix: "--assmb_map"

  assmb_step:
    label: Either "gene" or "exon" for which sequences to pull
    type: string
    inputBinding:
      prefix: "--assmb_step"

  spades_install:
    label: Location of the SPAdes installation
    type: Directory?
    inputBinding:
      prefix: "--spades_install"

  HGA_install:
    label: Location of the HGA installation
    type: Directory?
    inputBinding:
      prefix: "--HGA_install"

  SB_install:
    label: Location of the HGA installation
    type: Directory?
    inputBinding:
      prefix: "--SB_install"

  python2_install:
    label: Location of the Python2 installation
    type: Directory?
    inputBinding:
      prefix: "--python2_install"

  velvet_install:
    label: Location of the Velvet installation
    type: Directory?
    inputBinding:
      prefix: "--velvet_install"

  number_of_jobs:
    label: Number of assembly jobs to spawn
    type: int
    inputBinding:
      prefix: "--number_of_jobs"

  partitions:
    label: Number of partitions to use in HGA
    type: int?
    inputBinding:
      prefix: "--partitions"

  threads_per_job:
    label: Number of threads to use for each assembly job
    type: int?
    inputBinding:
      prefix: "--threads_per_job"

  memory_per_job:
    label: How much memory to limit for each individual assembly job
    type: int?
    inputBinding:
      prefix: "--memory_per_job"

  ea_map:
    label: Path to the file built from extract_alleles.py
    type: File?
    inputBinding:
      prefix: "--ea_map"

  sequences:
    label: Path to the sequence file built from extract_sequences.py
    type: File?
    inputBinding:
      prefix: "--fasta"


outputs:
  assembled_dir:
    type: Directory
    outputBinding:
      outputEval: $(inputs.assmb_path)


baseCommand: ["/usr/local/packages/python-3.5.2/bin/python","/local/scratch/matsu_cwl_tests/run_parallel_assembly.py"]