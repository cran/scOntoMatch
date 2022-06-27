## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, dpi=300)

## ----install------------------------------------------------------------------

## install from source
## library(devtools)
## devtools::install_github("YY-SONG0718/scOntoMatch")
library(scOntoMatch)
library(ontologyIndex)

## ----load data----------------------------------------------------------------
metadata = '../inst/extdata/metadata.tsv'

anno_col = 'cell_ontology_class'
onto_id_col = 'cell_ontology_id'

obo_file = '../inst/extdata/cl-basic.obo'
propagate_relationships = c('is_a', 'part_of')
ont <- ontologyIndex::get_OBO(obo_file, propagate_relationships = propagate_relationships)

## ----load adata---------------------------------------------------------------

obj_list = getSeuratRds(metadata = metadata, sep = "\t")

## -----------------------------------------------------------------------------
levels(factor((obj_list$TM_lung@meta.data$cell_ontology_class)))
levels(factor((obj_list$TS_lung@meta.data$cell_ontology_class)))

## ----ontoMultiMinimal---------------------------------------------------------
obj_list_minimal = scOntoMatch::ontoMultiMinimal(obj_list = obj_list, ont = ont, anno_col = anno_col, onto_id_col = onto_id_col)

## ----re-annotate--------------------------------------------------------------
obj_list$TS_lung@meta.data[[anno_col]] = as.character(obj_list$TS_lung@meta.data[[anno_col]])

## nk cell can certainly be matched
obj_list$TS_lung@meta.data[which(obj_list$TS_lung@meta.data[[anno_col]] == 'nk cell'), anno_col] = 'natural killer cell'

## there are type 1 and type 2 alveolar fibroblast which both belongs to fibroblast of lung

obj_list$TS_lung@meta.data[which(obj_list$TS_lung@meta.data[[anno_col]] == 'alveolar fibroblast'), anno_col] = 'fibroblast of lung'

## capillary aerocyte is a recently discovered new lung-specific cell type that is good to keep it
## Gillich, A., Zhang, F., Farmer, C.G. et al. Capillary cell-type specialization in the alveolus. Nature 586, 785–789 (2020). https://doi.org/10.1038/s41586-020-2822-7


## ----ontoMultiMinimal_new-----------------------------------------------------
obj_list_minimal = scOntoMatch::ontoMultiMinimal(obj_list = obj_list, ont = ont, anno_col = anno_col, onto_id_col = onto_id_col)

## ----plotOntoTree-------------------------------------------------------------


plotOntoTree(ont = ont, 
                          onts = names(getOntologyId(obj_list$TM_lung@meta.data[['cell_ontology_class']], ont = ont)), 
                          ont_query = names(getOntologyId(obj_list$TM_lung@meta.data[['cell_ontology_class']], ont = ont)),
                          plot_ancestors = TRUE,  roots = 'CL:0000548',
                          fontsize=25)

## ----plotOntoTree_two---------------------------------------------------------


plotOntoTree(ont = ont, 
                          onts = names(getOntologyId(obj_list$TS_lung@meta.data[['cell_ontology_class']], ont = ont)), 
                          ont_query = names(getOntologyId(obj_list$TS_lung@meta.data[['cell_ontology_class']], ont = ont)),
                          plot_ancestors = TRUE,  roots = 'CL:0000548',
                          fontsize=25)

## ----plotOntoTree_minimal-----------------------------------------------------

plotOntoTree(ont = ont, 
                          onts = names(getOntologyId(obj_list_minimal$TM_lung@meta.data[['cell_ontology_base']], ont = ont)), 
                          ont_query = names(getOntologyId(obj_list_minimal$TM_lung@meta.data[['cell_ontology_base']], ont = ont)),
                          plot_ancestors = TRUE,  roots = 'CL:0000548',
                          fontsize=25)

## ----plotOntoTree_minimal_two-------------------------------------------------

plotOntoTree(ont = ont, 
                          onts = names(getOntologyId(obj_list_minimal$TS_lung@meta.data[['cell_ontology_base']], ont = ont)), 
                          ont_query = names(getOntologyId(obj_list_minimal$TS_lung@meta.data[['cell_ontology_base']], ont = ont)),
                          plot_ancestors = TRUE,  roots = 'CL:0000548',
                          fontsize=25)

## ----ontoMultiMatch-----------------------------------------------------------

## perform ontoMatch on the original tree

obj_list_matched = scOntoMatch::ontoMultiMatch(obj_list = obj_list_minimal, anno_col = 'cell_ontology_base', onto_id_col = onto_id_col, ont = ont)

## ----plotMatchedOntoTree------------------------------------------------------

plts = plotMatchedOntoTree(ont = ont, obj_list = obj_list_matched,
                                 anno_col = 'cell_ontology_mapped', 
                                 onto_id_col = onto_id_col,
                                 roots = 'CL:0000548', fontsize=25)

## -----------------------------------------------------------------------------
plts[[1]]

## ----plotMatchedOntoTree_two--------------------------------------------------
plts[[2]]

## ----getOntologyName----------------------------------------------------------
getOntologyName(onto_id = c("CL:0000082"), ont = ont)


## ----getOntologyId------------------------------------------------------------
getOntologyId(obj_list$TM_lung@meta.data[[anno_col]], ont = ont)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

