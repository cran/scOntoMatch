% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{getOntoMinimal}
\alias{getOntoMinimal}
\title{match descendant terms to ancestor terms within a dataset}
\usage{
getOntoMinimal(ont, onts)
}
\arguments{
\item{ont}{the ontology object from get_OBO}

\item{onts}{a character vector of ontology id}
}
\value{
a named list for ontology id mapping looks like ontology_id:ontology_id
}
\description{
match descendant terms to ancestor terms within a dataset
}
\examples{
\dontrun{
getOntoMinimal(ont = ont, onts = c("CL0000548", "CL:0000066", "CL:0000082"))
}
}
