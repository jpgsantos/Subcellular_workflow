.insert.unit <- function(sbml,unit){
    i <- grep(pattern="<listOfUnitDefinitions>",sbml)
    n <- length(sbml)
    sbml=c(sbml[1:i],
           paste0('     <unitDefinition id="',unit$id,'" name="',unit$name,'">'),
           "      <listOfUnits>",
           paste0('      <unit kind="',unit$kind,'" ',
                  'multiplier="',unit$multiplier,'" ',
                  'scale="',unit$scale,'" ',
                  'exponent="',unit$exponent,'"/>'),
           "      </listOfUnits>",
           "     </unitDefinition>",
           sbml[i+1:n])
    return(sbml)
}

## Unit is a character array of length 1, 2 or 3:
## e.g.: c('m','m','2') which represents a square millimeter (mm^2)
.interpret.unit <- function(Unit){
    ## short and long SI prefixes
    giga=c('G','giga')
    mega=c('M','mega')
    kilo=c('k','kilo')
    milli=c('m','milli')
    micro=c('u','μ','micro')
    nano=c('n','nano')
    pico=c('p','pico')
    ## short and long unit names
    second=c("s","second")
    meter=c("m","meter","metre")
    liter=c("l","liter","litre")
    mole=c("mol","mole")
    print(paste0(Unit,collapse=''))
    u <- data.frame(id='substance',
                    name=paste0(Unit,collapse=''),
                    kind='dimensionless',
                    multiplier=1,
                    scale=1,
                    exponent=1)
    n <- length(Unit)
    message(sprintf("number of components in unit: %i\n",n))
    u$exponent=switch(n,1,1,as.numeric(Unit[3]))
    Kind <- switch(n,Unit[1],Unit[2],Unit[2])
    if (Kind %in% second){
        u$kind <- 'second'
        u$id <- 'time'
    }else if (Kind %in% meter){
        u$kind <- 'metre'
        u$id <- switch(u$exponent,'length','area','volume') 
    }else if (Kind %in% liter){
        u$kind <- 'litre'
        u$id <- 'volume'
    }else if (Kind %in% mole){
        u$kind <- 'mole'
        u$id <- 'substance'
    }

    Scale <- switch(n,1,Unit[1],Unit[1],Unit[1])
    if (Scale %in% giga){
        u$scale <- 9
    } else if (Scale %in% mega){
        u$scale <- 6
    } else if (Scale %in% kilo){
        u$scale <- 3
    } else if (Scale %in% milli){
        u$scale <- -3
    } else if (Scale %in% micro){
        u$scale <- -6
    } else if (Scale %in% nano){
        u$scale <- -9
    }else if (Scale %in% pico){
        u$scale <- -12
    }
    print(u)
    return(u)    
}

.fix.ids <- function(sbml,tag='species'){
    defs <- grep(pattern=paste0("<",tag,'[ ]'),sbml)
    n <- length(defs)
    Format <- paste0("%s_%0",nchar(n),"i")
    message(sprintf("fixing all items called «%s»",tag))
    Pattern.id <- paste0('^\\s*<',tag,'.*id="([^"]+)"')
    Pattern.name <- paste0('^\\s*<',tag,'.*name="([^"]+)"')
    for (i in 1:n){
        j <- defs[i]
        l <- sbml[j]
        message(sprintf("working on: «%s»",trimws(l)))
        
        r.id <- regexec(Pattern.id,l)
        m.id <- regmatches(l,r.id)

        r.name <- regexec(Pattern.name,l)
        m.name <- regmatches(l,r.name)

        id <- m.id[[1]][2]
        if (r.name[[1]][1]==-1){
            Name <- sprintf(Format,tag,i)
            message(sprintf("There is no name attribute, so I will use the auto-generated name «%s».",Name))
        } else {
            Name <- gsub('\\s','_',m.name[[1]][2])
        }
        message(sprintf("The id «%s» will be replaced with «%s»",id,Name))
        sbml <- gsub(id,Name,sbml,fixed=TRUE)
    }
    return(sbml)
}

## reads an sbml file as exported from MATLAB's simbiology toolbox and fixes it:
## replace "<ci> time </ci>" with "<csymbol ... > time </csymbol>"
## include default units, so that Copasi can use this file
## replace super long hash-based id's with names
sbml_fix <- function(filename,substanceUnit=c('n','mol'),volumeUnit=c('liter'),areaUnit=c('u','m',2),lengthUnit=c("u","m"),timeUnit=c('m','s')){
    ##if (filename==NULL){
    ##    d <- dir(pattern=".*xml$")
    ##    filename=d[1]
    ##}
    stopifnot(file.exists(filename))
    sbml <- readLines(filename)
    DefaultUnits=list(substanceUnit,volumeUnit,timeUnit,areaUnit)
    for (u in DefaultUnits){
        unit <- .interpret.unit(u)
        sbml <- .insert.unit(sbml,unit)
    }
    tags=c('model','compartment','species','parameter','reaction')
    for (tg in tags) {
        sbml <- .fix.ids(sbml,tg)
    }
    sbml <- gsub('<ci>\\s*time\\s*</ci>','<csymbol encoding="text" definitionURL="http://www.sbml.org/sbml/symbols/time"> time </csymbol>',sbml)
    cat(sbml,sep="\n",file=paste0("Fixed_",filename))
}
