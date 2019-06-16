#defining rules.
rule2 <- function(word) {
    if (grepl("^[aeiou].+$", word) == TRUE) {
        res <- paste(word, "yay", sep = "", collapse = NULL)
    }
    return(res)
}


rule3 <- function(word) {
    if (grepl("^[^aeiou]+$", word) == TRUE) {
        res <- paste(word, "yay", sep = "", collapse = NULL)
    }
    return(res)
}


rule1 <- function(word) {
    if (grepl("^[^aeiou].+", word) == TRUE) {
        place <- as.numeric(regexpr("[aeiou]", word))
        first <- substr(word, start = 1, stop = place - 1)
        spl <- strsplit(word, split = "")[[1]]  #had to split it so that I can access the word's length
        second <- substr(word, start = place, stop = length(spl))
        secondfirst <- paste(second, first, sep = "", collapse = NULL)
        res <- paste(secondfirst, "ay", sep = "", collapse = NULL)
    }
    return(res)
}

#piglatinrule recognizes which rule should apply to a word.
pigLatinRule <- function(word) {
    if (grepl("^[^aeiou]+$", word)) {
        res <- "novowels"
    } else {
        if (grepl("^[aeiou].+$", word)) {
            res <- "vowel"
        } else {
            if (grepl("^[^aeiou].+$", word)) {
                res <- "consonant"
            }
        }
    }
    return(res)
}
#piglatinizer takes single word and convert in into pig latin word..
pigLatinizer <- function(word) {
    res <- switch(pigLatinRule(word), consonant = rule1(word), vowel = rule2(word), 
        novowels = rule3(word))
    return(res)
}

# writing any string to speciofied file name..
write_file <- function (file ,str){     
    new_file<-file(file)
    writeLines(str, new_file) 
    close(new_file)
}

# processing a txt file , read content coinvert it into pig latin and dump into new_file
process <- function (file){     
    new_str <- ''
    con = file(file, "r")
    while ( TRUE ) {
        line = readLines(con, n = 1)
        if ( length(line) == 0 ) {
           break
         }
         for ( word in strsplit(line ,' ')){
              new_str = paste(new_str , pigLatinizer(word))
           } 
    }
    new_str = paste(new_str ,'\n')
    print(new_str )
    write_file(file ,new_str)
    close(con)
}

#main function.
files <- list.files(pattern = "^(.*)txt$")
for  (file in files){
   print(file)
   process(file)
}
