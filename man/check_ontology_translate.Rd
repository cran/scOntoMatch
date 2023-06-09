% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helper_functions.R
\name{check_ontology_translate}
\alias{check_ontology_translate}
\title{make sure ontology names are all translated to ontology ids
while warning, consider manual reannotation}
\usage{
check_ontology_translate(obj, onts, ont, anno_col)
}
\arguments{
\item{obj}{seurat rds object}

\item{onts}{ontology ids from translate}

\item{ont}{ontologyIndex object}

\item{anno_col}{annotation column in obj@meta.data that is translated to onts ids}
}
\value{
do not return a value but output messages
}
\description{
make sure ontology names are all translated to ontology ids
while warning, consider manual reannotation
}
