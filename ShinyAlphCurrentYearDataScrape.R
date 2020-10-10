library(tidyverse)
library(cronR)
setwd("~/ShinyAlphPopulating")
#####################################################################################
setwd("~/ShinyAlph")

#MLS - Current Year
updateMLS = function(){
  setwd("~/ShinyAlph")
  scrapeMLS = function(seasonList){
    currentSeason = "2020"
    require(rvest)
    require(dplyr)
    empty_as_zero <- function(x){
      if("factor" %in% class(x)) x <- as.character(x) ## since ifelse wont work with factors
      ifelse(as.character(x)!="", x, 0)
    }
    cleanShooting = function(frame){
      
      names(frame)[1]="Rank"
      names(frame)[2]="Player"
      names(frame)[3]="Nation"
      names(frame)[4]="Position"
      names(frame)[5]="Team"
      names(frame)[6]="Age"
      names(frame)[7]="BirthYear"
      names(frame)[8]="NinetiesPlayed"
      names(frame)[9]="Goals"
      names(frame)[10]="Shots"
      names(frame)[11]="ShotsOnTarget"
      names(frame)[12]="ShotOnTargetPercent"
      names(frame)[19] = "PKatt"
      names(frame)[20] = "xG"
      names(frame)[21] = "nonPenaltyxG"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      frame = frame %>% select(2:12, 19:21)
      
      frame = frame %>% 
        mutate(ShotOnTargetPercent = ifelse(ShotsOnTarget==0,0,ShotOnTargetPercent))
      
      return(frame)
      
    }
    cleanPassing = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "Age"
      names(frame)[7] = "BirthYear"
      names(frame)[8] = "NinetiesPlayed"
      names(frame)[9] = "PassesCompleted"
      names(frame)[10] = "PassesAttempted"
      names(frame)[11] = "PassCompletionPercentage"
      names(frame)[12] = "TotalPassingDistance"
      names(frame)[13] = "PassPrgDist"
      names(frame)[14] = "ShPassesCompleted"
      names(frame)[15] = "ShPassAtt"
      names(frame)[16] = "SortPassCompletionPercentage"
      names(frame)[17] = "MedPassesCompleted"
      names(frame)[18] = "MedPassesAttempted"
      names(frame)[19] = "MedPassCompletionPercentage"
      names(frame)[20] = "LongPassesCompleted"
      names(frame)[21] = "LngPassAtt"
      names(frame)[22] = "LongPassCompletionPercentage"
      names(frame)[24] = "xA"
      names(frame)[26] = "KeyPasses"
      names(frame)[27] = "PassesThatEnterFinalThird"
      names(frame)[28] = "PPA"
      names(frame)[29] = "CrsPA"
      names(frame)[30] = "ProgPasses"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:22, 24,26:30)
      
      return(frame)
    }
    cleanPossession = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "Age"
      names(frame)[7] = "BirthYear"
      names(frame)[8] = "NinetiesPlayed"
      names(frame)[9] = "Touches"
      names(frame)[10] = "DefensivePenaltyAreaTouches"
      names(frame)[11] = "DefensiveThirdTouches"
      names(frame)[12] = "MiddleThirdTouches"
      names(frame)[13] = "AttackingThirdTouches"
      names(frame)[14] = "AttackingPenaltyAreaTouches"
      names(frame)[16] = "SuccessfulDribbles"
      names(frame)[17] = "DribblesAttempted"
      names(frame)[18] = "DribbleSuccessPercent"
      names(frame)[19] = "TotalPlayersDribbledPast"
      names(frame)[21] = "TotalCarries"
      names(frame)[22] = "TotalCarryDistance"
      names(frame)[23] = "TotalCarryProgressiveDistance"
      names(frame)[24] = "NumTimesTarget"
      names(frame)[25] = "TotalPassesReceived"
      
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:14,16,17,18,19,21:25)
      
      return(frame)
    }
    cleanDefense = function(scrapedDefenseFrame){
      names(scrapedDefenseFrame)[2] = "Player"
      names(scrapedDefenseFrame)[3] = "Nation"
      names(scrapedDefenseFrame)[4] = "Position"
      names(scrapedDefenseFrame)[5] = "Team"
      names(scrapedDefenseFrame)[6] = "Age"
      names(scrapedDefenseFrame)[7] = "BirthYear"
      names(scrapedDefenseFrame)[8] = "NinetiesPlayed"
      names(scrapedDefenseFrame)[9] = "TotalTackles"
      names(scrapedDefenseFrame)[10] = "TacklesWon"
      names(scrapedDefenseFrame)[11] = "DefThirdTacklesWon"
      names(scrapedDefenseFrame)[12] = "MidThirdTacklesWon"
      names(scrapedDefenseFrame)[13] = "AttThirdTacklesWon"
      names(scrapedDefenseFrame)[14] = "TacklesAgainstDribblesWon"
      names(scrapedDefenseFrame)[15] = "DribblesAgainst"
      names(scrapedDefenseFrame)[16] = "DribbleTackledPercentage"
      names(scrapedDefenseFrame)[17] = "DribbledPast"
      names(scrapedDefenseFrame)[18] = "TotalPressures"
      names(scrapedDefenseFrame)[19] = "SuccessfulPressures"
      names(scrapedDefenseFrame)[20] = "SuccessfulPressurePercent"
      names(scrapedDefenseFrame)[21] = "DefThirdPressures"
      names(scrapedDefenseFrame)[22] = "MidThirdPressures"
      names(scrapedDefenseFrame)[23] = "AttThirdPressures"
      names(scrapedDefenseFrame)[24] = "TotalBlocks"
      names(scrapedDefenseFrame)[25] = "ShotsBlocked"
      names(scrapedDefenseFrame)[26] = "ShotsBlockedOnTarget"
      names(scrapedDefenseFrame)[27] = "PassesBlocked"
      names(scrapedDefenseFrame)[28] = "Interception"
      names(scrapedDefenseFrame)[30] = "Clearances"
      names(scrapedDefenseFrame)[31] = "Errors"
      
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% 
        select(2:28,30,31) %>% 
        filter(Player != "Player")
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% mutate_each(funs(empty_as_zero))
      
    }
    cleanPlayingTime = function(scrapedPlayingTime){
      names(scrapedPlayingTime)[2] = "Player"
      names(scrapedPlayingTime)[3] = "Nation"
      names(scrapedPlayingTime)[4] = "Position"
      names(scrapedPlayingTime)[5] = "Team"
      names(scrapedPlayingTime)[6] = "Age"
      names(scrapedPlayingTime)[7] = "BirthYear"
      names(scrapedPlayingTime)[9] = "Min"
      names(scrapedPlayingTime)[13] = "Starts"
      
      scrapedPlayingTime = scrapedPlayingTime[-1,]
      
      scrapedPlayingTime = scrapedPlayingTime %>% select(2:7,9,13)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Player!="Player")
      scrapedPlayingTime$Min = gsub(",","",scrapedPlayingTime$Min)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Min!="0", Min!=0)
      return(scrapedPlayingTime)
    }
    cleanPassTypes = function(scrapedPassTypes){
      names(scrapedPassTypes)[2] = "Player"
      names(scrapedPassTypes)[3] = "Nation"
      names(scrapedPassTypes)[4] = "Position"
      names(scrapedPassTypes)[5] = "Team"
      names(scrapedPassTypes)[6] = "Age"
      names(scrapedPassTypes)[7] = "BirthYear"
      names(scrapedPassTypes)[8] = "NinetiesPlayed"
      names(scrapedPassTypes)[10] = "LivePasses"
      names(scrapedPassTypes)[14] = "PassPress"
      
      scrapedPassTypes = scrapedPassTypes %>% select(2:8,10,14)
      scrapedPassTypes = scrapedPassTypes[-1,]
      scrapedPassTypes = scrapedPassTypes %>% filter(Player!="Player")
      return(scrapedPassTypes)
    }
    cleanMisc = function(scrapedMisc){
      names(scrapedMisc)[2] = "Player"
      names(scrapedMisc)[3] = "Nation"
      names(scrapedMisc)[4] = "Position"
      names(scrapedMisc)[5] = "Team"
      names(scrapedMisc)[6] = "Age"
      names(scrapedMisc)[7] = "BirthYear"
      names(scrapedMisc)[8] = "NinetiesPlayed"
      names(scrapedMisc)[13] = "Fld"
      names(scrapedMisc)[18] = "PKWon"
      names(scrapedMisc)[21] = "Recov"
      
      
      scrapedMisc = scrapedMisc %>% select(2:8,13,18,21)
      scrapedMisc = scrapedMisc[-1,]
      scrapedMisc = scrapedMisc %>% filter(Player!="Player")
      return(scrapedMisc)
    }
    
    
    ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###
    statTypes = c("passing", "shooting", "defense", "possession", "misc")
    availableSeasons = c("2018", "2019", "2020")
    if(unique(seasonList %in% availableSeasons)[1] == TRUE & 
       is.na(unique(seasonList %in% availableSeasons)[2])==TRUE){
      
      passingTables = data.frame()
      shootingTables = data.frame()
      possessionTables = data.frame()
      defenseTables = data.frame()
      miscTables = data.frame()
      playingTimeTables = data.frame()
      passTypeTables = data.frame()
      
      
      if(seasonList!="2020"){
        seasonListWithoutCurrentSeason = seasonList[seasonList != currentSeason]
        for (h in 1:length(seasonListWithoutCurrentSeason)) {
          for (i in 1:length(statTypes)) {
            print(paste("Now Scraping", unique(statTypes)[i], "Stats from", unique(seasonListWithoutCurrentSeason)[h], sep = " "))
            url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
            season = unique(seasonListWithoutCurrentSeason)[h]
            statType = unique(statTypes)[i]
            statType2 = paste("stats",unique(statTypes)[i],sep="_")
            
            code = ifelse(season==2019, "2798","1759")
            paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
            url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
            
            page <- 
              read_html(url2)
            table <- page %>% html_table()
            table <- table[[1]] 
            
            if(statType == "passing"){
              passingTable = cleanPassing(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
              passingTables = rbind(passingTables, passingTable)
            }
            
            if(statType == "shooting"){
              shootingTable = cleanShooting(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
              shootingTables = rbind(shootingTables, shootingTable)
            }
            
            if(statType == "possession"){
              possessionTable = cleanPossession(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
              possessionTables = rbind(possessionTables, possessionTable)
            }
            if(statType == "defense"){
              defenseTable = cleanDefense(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              defenseTables = rbind(defenseTables, defenseTable)
            }
            if(statType == "misc"){
              miscTable = cleanMisc(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              miscTables = rbind(miscTables, miscTable)
            }
            
          }
        }
        
        
        
        playingTimeTables = data.frame()
        for (j in 1:length(seasonListWithoutCurrentSeason)) {
          print(paste("Now Scraping Playing Time From", unique(seasonListWithoutCurrentSeason)[j], sep = " "))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          season = unique(seasonListWithoutCurrentSeason)[j]
          statType = "playingtime"
          statType2 = "stats_playing_time"
          
          code = ifelse(season==2019, "2798","1759")
          paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          
          playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[j]) %>% mutate(League = "MLS")
          playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
          playingTimeTables = rbind(playingTimeTables, playingTimeTable)
          
        }
        #playingTimeTables = playingTimeTables %>% filter(Min!="0")
        
        passTypeTables = data.frame()
        for (k in 1:length(seasonListWithoutCurrentSeason)) {
          print(paste("Now Scraping Pass Types from ", unique(seasonList)[k]))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          season = unique(seasonListWithoutCurrentSeason)[k]
          statType = "passing_types"
          statType2 = "stats_passing_types"
          
          code = ifelse(season==2019, "2798","1759")
          paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          passTypeTable = cleanPassTypes(table) %>% mutate(Season = unique(seasonList)[k]) %>% mutate(League = "MLS")
          passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
          passTypeTables = rbind(passTypeTables, passTypeTable)
          
        }
        
      }
      if(currentSeason %in% seasonList){
        for (z in 1:length(statTypes)) {
          print(paste("Now Scraping", unique(statTypes)[z], "Stats from Current Season", sep = " "))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          statType = unique(statTypes)[z]
          statType2 = paste("stats_", statType, sep = "")
          paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          if(statType == "passing"){
            passingTable = cleanPassing(table) %>% 
              mutate(Season = currentSeason) %>% mutate(League = "MLS")
            passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
            passingTables = rbind(passingTables, passingTable)
          }
          
          if(statType == "shooting"){
            shootingTable = cleanShooting(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
            shootingTables = rbind(shootingTables, shootingTable)
          }
          
          if(statType == "possession"){
            possessionTable = cleanPossession(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
            possessionTables = rbind(possessionTables, possessionTable)
          }
          if(statType == "defense"){
            defenseTable = cleanDefense(table) %>% mutate(Season =currentSeason) %>% mutate(League = "MLS")
            defenseTables = rbind(defenseTables, defenseTable)
          }
          if(statType == "misc"){
            miscTable = cleanMisc(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            miscTables = rbind(miscTables, miscTable)
          }
        }
        
        
        print("Now Scraping Playing Time from Current Season")
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
        statType = "playingtime"
        statType2 = "stats_playing_time"
        paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
        url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
        
        page <- 
          read_html(url2)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        
        playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
        playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
        playingTimeTables = rbind(playingTimeTables, playingTimeTable)
        playingTimeTables = playingTimeTables %>% filter(Min!=0, Min!="0")
        
        print("Now Scraping Pass Types from Current Season")
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
        statType = "passing_types"
        statType2 = "stats_passing_types"
        paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
        url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
        page <- 
          read_html(url2)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        passTypeTable = cleanPassTypes(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
        passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
        passTypeTables = rbind(passTypeTables, passTypeTable)
        
        
      }
      
      
      frame = left_join(passingTables, shootingTables, 
                        by = c("Player", "Nation", "Position", "Team", 
                               "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(possessionTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(defenseTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(passTypeTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>%
        left_join(miscTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(playingTimeTables, by = c("Player", "Nation", "Position", "Team", 
                                            "League", "Age", "BirthYear", "Season"))
      
      frameInfo = frame %>% select(Player, Nation,Position, Team, League, Season)
      frameMutate = frame %>% select(-names(frameInfo))
      frameMutate = frameMutate %>% 
        mutate_all(funs(as.numeric(.)))
      frame = cbind.data.frame(frameInfo, frameMutate)
      
      return(frame)
    }
    
    else{
      return(print("Seasons Entered Not Correct"))
    }
  }
  currentYearMLSData = scrapeMLS("2020")
  write.csv(currentYearMLSData,"currentYearMLSData.csv")
}

updateEurope = function(){
  #Europe - Current Year
  setwd("~/ShinyAlph")
  bigFiveScraper = function(seasonList){
    require(rvest)
    require(dplyr)
    empty_as_zero <- function(x){
      if("factor" %in% class(x)) x <- as.character(x) ## since ifelse wont work with factors
      ifelse(as.character(x)!="", x, 0)
    }
    cleanShooting = function(frame){
      
      names(frame)[1]="Rank"
      names(frame)[2]="Player"
      names(frame)[3]="Nation"
      names(frame)[4]="Position"
      names(frame)[5]="Team"
      names(frame)[6]="League"
      names(frame)[7]="Age"
      names(frame)[8]="BirthYear"
      names(frame)[9]="NinetiesPlayed"
      names(frame)[10]="Goals"
      names(frame)[11]="Shots"
      names(frame)[12]="ShotsOnTarget"
      names(frame)[13]="ShotOnTargetPercent"
      names(frame)[20] = "PKatt"
      names(frame)[21] = "xG"
      names(frame)[22] = "nonPenaltyxG"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      frame = frame %>% select(2:13, 10,20,21,22)
      
      frame = frame %>% 
        mutate(ShotOnTargetPercent = ifelse(ShotsOnTarget==0,0,ShotOnTargetPercent))
      
      return(frame)
      
    }
    cleanPassing = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "League"
      names(frame)[7] = "Age"
      names(frame)[8] = "BirthYear"
      names(frame)[9] = "NinetiesPlayed"
      names(frame)[10] = "PassesCompleted"
      names(frame)[11] = "PassesAttempted"
      names(frame)[12] = "PassCompletionPercentage"
      names(frame)[13] = "TotalPassingDistance"
      names(frame)[14] = "PassPrgDist"
      names(frame)[15] = "ShPassesCompleted"
      names(frame)[16] = "ShPassAtt"
      names(frame)[17] = "SortPassCompletionPercentage"
      names(frame)[18] = "MedPassesCompleted"
      names(frame)[19] = "MedPassesAttempted"
      names(frame)[20] = "MedPassCompletionPercentage"
      names(frame)[21] = "LongPassesCompleted"
      names(frame)[22] = "LngPassAtt"
      names(frame)[23] = "LongPassCompletionPercentage"
      names(frame)[25] = "xA"
      names(frame)[27] = "KeyPasses"
      names(frame)[28] = "PassesThatEnterFinalThird"
      names(frame)[29] = "PPA"
      names(frame)[30] = "CrsPA"
      names(frame)[31] = "ProgPasses"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:23, 25,27:31)
      
      return(frame)
    }
    cleanPossession = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "League"
      names(frame)[7] = "Age"
      names(frame)[8] = "BirthYear"
      names(frame)[9] = "NinetiesPlayed"
      names(frame)[10] = "Touches"
      names(frame)[11] = "DefensivePenaltyAreaTouches"
      names(frame)[12] = "DefensiveThirdTouches"
      names(frame)[13] = "MiddleThirdTouches"
      names(frame)[14] = "AttackingThirdTouches"
      names(frame)[15] = "AttackingPenaltyAreaTouches"
      names(frame)[17] = "SuccessfulDribbles"
      names(frame)[18] = "DribblesAttempted"
      names(frame)[19] = "DribbleSuccessPercent"
      names(frame)[20] = "TotalPlayersDribbledPast"
      names(frame)[22] = "TotalCarries"
      names(frame)[23] = "TotalCarryDistance"
      names(frame)[24] = "TotalCarryProgressiveDistance"
      names(frame)[25] = "NumTimesTarget"
      names(frame)[26] = "TotalPassesReceived"
      
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:15,17,18,19,20,22:26)
      
      return(frame)
    }
    cleanDefense = function(scrapedDefenseFrame){
      names(scrapedDefenseFrame)[2] = "Player"
      names(scrapedDefenseFrame)[3] = "Nation"
      names(scrapedDefenseFrame)[4] = "Position"
      names(scrapedDefenseFrame)[5] = "Team"
      names(scrapedDefenseFrame)[6] = "League"
      names(scrapedDefenseFrame)[7] = "Age"
      names(scrapedDefenseFrame)[8] = "BirthYear"
      names(scrapedDefenseFrame)[9] = "NinetiesPlayed"
      names(scrapedDefenseFrame)[10] = "TotalTackles"
      names(scrapedDefenseFrame)[11] = "TacklesWon"
      names(scrapedDefenseFrame)[12] = "DefThirdTacklesWon"
      names(scrapedDefenseFrame)[13] = "MidThirdTacklesWon"
      names(scrapedDefenseFrame)[14] = "AttThirdTacklesWon"
      names(scrapedDefenseFrame)[15] = "TacklesAgainstDribblesWon"
      names(scrapedDefenseFrame)[16] = "DribblesAgainst"
      names(scrapedDefenseFrame)[17] = "DribbleTackledPercentage"
      names(scrapedDefenseFrame)[18] = "DribbledPast"
      names(scrapedDefenseFrame)[19] = "TotalPressures"
      names(scrapedDefenseFrame)[20] = "SuccessfulPressures"
      names(scrapedDefenseFrame)[21] = "SuccessfulPressurePercent"
      names(scrapedDefenseFrame)[22] = "DefThirdPressures"
      names(scrapedDefenseFrame)[23] = "MidThirdPressures"
      names(scrapedDefenseFrame)[24] = "AttThirdPressures"
      names(scrapedDefenseFrame)[25] = "TotalBlocks"
      names(scrapedDefenseFrame)[26] = "ShotsBlocked"
      names(scrapedDefenseFrame)[27] = "ShotsBlockedOnTarget"
      names(scrapedDefenseFrame)[28] = "PassesBlocked"
      names(scrapedDefenseFrame)[29] = "Interception"
      names(scrapedDefenseFrame)[31] = "Clearances"
      names(scrapedDefenseFrame)[32] = "Errors"
      
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% 
        select(2:29,31,32) %>% 
        filter(Player != "Player")
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% mutate_each(funs(empty_as_zero))
      
    }
    cleanPlayingTime = function(scrapedPlayingTime){
      names(scrapedPlayingTime)[2] = "Player"
      names(scrapedPlayingTime)[3] = "Nation"
      names(scrapedPlayingTime)[4] = "Position"
      names(scrapedPlayingTime)[5] = "Team"
      names(scrapedPlayingTime)[6] = "League"
      names(scrapedPlayingTime)[7] = "Age"
      names(scrapedPlayingTime)[8] = "BirthYear"
      names(scrapedPlayingTime)[10] = "Min"
      names(scrapedPlayingTime)[14] = "Starts"
      
      scrapedPlayingTime = scrapedPlayingTime[-1,]
      
      scrapedPlayingTime = scrapedPlayingTime %>% select(2:8,10,14)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Player!="Player")
      scrapedPlayingTime$Min = gsub(",","",scrapedPlayingTime$Min)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Min!="0", Min!=0)
      return(scrapedPlayingTime)
    }
    cleanPassTypes = function(scrapedPassTypes){
      names(scrapedPassTypes)[2] = "Player"
      names(scrapedPassTypes)[3] = "Nation"
      names(scrapedPassTypes)[4] = "Position"
      names(scrapedPassTypes)[5] = "Team"
      names(scrapedPassTypes)[6] = "League"
      names(scrapedPassTypes)[7] = "Age"
      names(scrapedPassTypes)[8] = "BirthYear"
      names(scrapedPassTypes)[9] = "NinetiesPlayed"
      names(scrapedPassTypes)[11] = "LivePasses"
      names(scrapedPassTypes)[15] = "PassPress"
      
      scrapedPassTypes = scrapedPassTypes %>% select(2:9,11,15)
      scrapedPassTypes = scrapedPassTypes[-1,]
      scrapedPassTypes = scrapedPassTypes %>% filter(Player!="Player")
      return(scrapedPassTypes)
    }
    cleanMisc = function(scrapedMisc){
      names(scrapedMisc)[2] = "Player"
      names(scrapedMisc)[3] = "Nation"
      names(scrapedMisc)[4] = "Position"
      names(scrapedMisc)[5] = "Team"
      names(scrapedMisc)[6] = "League"
      names(scrapedMisc)[7] = "Age"
      names(scrapedMisc)[8] = "BirthYear"
      names(scrapedMisc)[9] = "NinetiesPlayed"
      names(scrapedMisc)[14] = "Fld"
      names(scrapedMisc)[19] = "PKWon"
      names(scrapedMisc)[22] = "Recov"
      
      
      scrapedMisc = scrapedMisc %>% select(2:9,14,19,22)
      scrapedMisc = scrapedMisc[-1,]
      scrapedMisc = scrapedMisc %>% filter(Player!="Player")
      return(scrapedMisc)
    }
    
    
    ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###
    statTypes = c("passing", "shooting", "defense", "possession", "misc")
    availableSeasons = c("2017-2018", "2018-2019", "2019-2020", "2020-2021")
    
    if(unique(seasonList %in% availableSeasons)[1] == TRUE & 
       is.na(unique(seasonList %in% availableSeasons)[2])==TRUE ){
      passingTables = data.frame()
      shootingTables = data.frame()
      possessionTables = data.frame()
      defenseTables = data.frame()
      miscTables = data.frame()
      for (h in 1:length(seasonList)) {
        for (i in 1:length(statTypes)) {
          print(paste("Now Scraping", unique(statTypes)[i], "Stats from", unique(seasonList)[h], sep = " "))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
          season = unique(seasonList)[h]
          statType = unique(statTypes)[i]
          statType2 = paste("stats_",unique(statTypes)[i], sep = "")
          playerOrTeam = "players"
          url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
          paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
          fullURL = paste(paste1, statType2, sep = "")
          
          page <- 
            read_html(fullURL)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          if(statType == "passing"){
            passingTable = cleanPassing(table) %>% mutate(Season = unique(seasonList)[h])
            passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
            passingTables = rbind(passingTables, passingTable)
          }
          
          if(statType == "shooting"){
            shootingTable = cleanShooting(table) %>% mutate(Season = unique(seasonList)[h])
            shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
            shootingTables = rbind(shootingTables, shootingTable)
          }
          
          if(statType == "possession"){
            possessionTable = cleanPossession(table) %>% mutate(Season = unique(seasonList)[h])
            possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
            possessionTables = rbind(possessionTables, possessionTable)
          }
          if(statType == "defense"){
            defenseTable = cleanDefense(table) %>% mutate(Season = unique(seasonList)[h])
            defenseTables = rbind(defenseTables, defenseTable)
          }
          if(statType == "misc"){
            miscTable = cleanMisc(table) %>% mutate(Season = unique(seasonList)[h])
            miscTables = rbind(miscTables, miscTable)
          }
        }
      }
      
      playingTimeTables = data.frame()
      for (j in 1:length(seasonList)) {
        print(j)
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
        season = unique(seasonList)[j]
        statType = "playingtime"
        statType2 = "stats_playing_time"
        playerOrTeam = "players"
        url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
        paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
        fullURL = paste(paste1, statType2, sep = "")
        
        page <- 
          read_html(fullURL)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = unique(seasonList)[j])
        playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
        playingTimeTables = rbind(playingTimeTables, playingTimeTable)
      }
      playingTimeTables = playingTimeTables %>% filter(Min!="0")
      
      passTypeTables = data.frame()
      for (k in 1:length(seasonList)) {
        print(k)
        
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
        season = unique(seasonList)[k]
        statType = "passing_types"
        statType2 = "stats_passing_types"
        playerOrTeam = "players"
        url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
        paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
        fullURL = paste(paste1, statType2, sep = "")
        
        page <- 
          read_html(fullURL)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        passTypeTable = cleanPassTypes(table) %>% mutate(Season = unique(seasonList)[k])
        passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
        passTypeTables = rbind(passTypeTables, passTypeTable)
      }
      
      frame = left_join(passingTables, shootingTables, 
                        by = c("Player", "Nation", "Position", "Team", 
                               "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(possessionTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(defenseTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(passTypeTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>%
        left_join(miscTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(playingTimeTables, by = c("Player", "Nation", "Position", "Team", 
                                            "League", "Age", "BirthYear", "Season"))
      
      frameInfo = frame %>% select(Player, Nation,Position, Team, League, Season)
      frameMutate = frame %>% select(-names(frameInfo))
      frameMutate = frameMutate %>% 
        mutate_all(funs(as.numeric(.)))
      frame = cbind.data.frame(frameInfo, frameMutate)
      
      return(frame)
    }
    else{
      return(print("Seasons Entered Not Correct"))
    }
  }
  currentYearEurope = bigFiveScraper(c("2020-2021"))
  
  write.csv(currentYearEurope,"currentYearEuropeData.csv")
}

bigFiveScraper = function(seasonList){
  require(rvest)
  require(dplyr)
  empty_as_zero <- function(x){
    if("factor" %in% class(x)) x <- as.character(x) ## since ifelse wont work with factors
    ifelse(as.character(x)!="", x, 0)
  }
  cleanShooting = function(frame){
    
    names(frame)[1]="Rank"
    names(frame)[2]="Player"
    names(frame)[3]="Nation"
    names(frame)[4]="Position"
    names(frame)[5]="Team"
    names(frame)[6]="League"
    names(frame)[7]="Age"
    names(frame)[8]="BirthYear"
    names(frame)[9]="NinetiesPlayed"
    names(frame)[10]="Goals"
    names(frame)[11]="Shots"
    names(frame)[12]="ShotsOnTarget"
    names(frame)[13]="ShotOnTargetPercent"
    names(frame)[20] = "PKatt"
    names(frame)[21] = "xG"
    names(frame)[22] = "nonPenaltyxG"
    
    frame = frame[-1,]
    
    frame = frame[which(frame$Player != "Player"),]
    frame = frame %>% select(2:13, 10,20,21,22)
    
    frame = frame %>% 
      mutate(ShotOnTargetPercent = ifelse(ShotsOnTarget==0,0,ShotOnTargetPercent))
    
    return(frame)
    
  }
  cleanPassing = function(frame){
    
    names(frame)[2] = "Player"
    names(frame)[3] = "Nation"
    names(frame)[4] = "Position"
    names(frame)[5] = "Team"
    names(frame)[6] = "League"
    names(frame)[7] = "Age"
    names(frame)[8] = "BirthYear"
    names(frame)[9] = "NinetiesPlayed"
    names(frame)[10] = "PassesCompleted"
    names(frame)[11] = "PassesAttempted"
    names(frame)[12] = "PassCompletionPercentage"
    names(frame)[13] = "TotalPassingDistance"
    names(frame)[14] = "PassPrgDist"
    names(frame)[15] = "ShPassesCompleted"
    names(frame)[16] = "ShPassAtt"
    names(frame)[17] = "SortPassCompletionPercentage"
    names(frame)[18] = "MedPassesCompleted"
    names(frame)[19] = "MedPassesAttempted"
    names(frame)[20] = "MedPassCompletionPercentage"
    names(frame)[21] = "LongPassesCompleted"
    names(frame)[22] = "LngPassAtt"
    names(frame)[23] = "LongPassCompletionPercentage"
    names(frame)[25] = "xA"
    names(frame)[27] = "KeyPasses"
    names(frame)[28] = "PassesThatEnterFinalThird"
    names(frame)[29] = "PPA"
    names(frame)[30] = "CrsPA"
    names(frame)[31] = "ProgPasses"
    
    frame = frame[-1,]
    
    frame = frame[which(frame$Player != "Player"),]
    
    frame = frame %>% select(2:23, 25,27:31)
    
    return(frame)
  }
  cleanPossession = function(frame){
    
    names(frame)[2] = "Player"
    names(frame)[3] = "Nation"
    names(frame)[4] = "Position"
    names(frame)[5] = "Team"
    names(frame)[6] = "League"
    names(frame)[7] = "Age"
    names(frame)[8] = "BirthYear"
    names(frame)[9] = "NinetiesPlayed"
    names(frame)[10] = "Touches"
    names(frame)[11] = "DefensivePenaltyAreaTouches"
    names(frame)[12] = "DefensiveThirdTouches"
    names(frame)[13] = "MiddleThirdTouches"
    names(frame)[14] = "AttackingThirdTouches"
    names(frame)[15] = "AttackingPenaltyAreaTouches"
    names(frame)[17] = "SuccessfulDribbles"
    names(frame)[18] = "DribblesAttempted"
    names(frame)[19] = "DribbleSuccessPercent"
    names(frame)[20] = "TotalPlayersDribbledPast"
    names(frame)[22] = "TotalCarries"
    names(frame)[23] = "TotalCarryDistance"
    names(frame)[24] = "TotalCarryProgressiveDistance"
    names(frame)[25] = "NumTimesTarget"
    names(frame)[26] = "TotalPassesReceived"
    
    
    frame = frame[-1,]
    
    frame = frame[which(frame$Player != "Player"),]
    
    frame = frame %>% select(2:15,17,18,19,20,22:26)
    
    return(frame)
  }
  cleanDefense = function(scrapedDefenseFrame){
    names(scrapedDefenseFrame)[2] = "Player"
    names(scrapedDefenseFrame)[3] = "Nation"
    names(scrapedDefenseFrame)[4] = "Position"
    names(scrapedDefenseFrame)[5] = "Team"
    names(scrapedDefenseFrame)[6] = "League"
    names(scrapedDefenseFrame)[7] = "Age"
    names(scrapedDefenseFrame)[8] = "BirthYear"
    names(scrapedDefenseFrame)[9] = "NinetiesPlayed"
    names(scrapedDefenseFrame)[10] = "TotalTackles"
    names(scrapedDefenseFrame)[11] = "TacklesWon"
    names(scrapedDefenseFrame)[12] = "DefThirdTacklesWon"
    names(scrapedDefenseFrame)[13] = "MidThirdTacklesWon"
    names(scrapedDefenseFrame)[14] = "AttThirdTacklesWon"
    names(scrapedDefenseFrame)[15] = "TacklesAgainstDribblesWon"
    names(scrapedDefenseFrame)[16] = "DribblesAgainst"
    names(scrapedDefenseFrame)[17] = "DribbleTackledPercentage"
    names(scrapedDefenseFrame)[18] = "DribbledPast"
    names(scrapedDefenseFrame)[19] = "TotalPressures"
    names(scrapedDefenseFrame)[20] = "SuccessfulPressures"
    names(scrapedDefenseFrame)[21] = "SuccessfulPressurePercent"
    names(scrapedDefenseFrame)[22] = "DefThirdPressures"
    names(scrapedDefenseFrame)[23] = "MidThirdPressures"
    names(scrapedDefenseFrame)[24] = "AttThirdPressures"
    names(scrapedDefenseFrame)[25] = "TotalBlocks"
    names(scrapedDefenseFrame)[26] = "ShotsBlocked"
    names(scrapedDefenseFrame)[27] = "ShotsBlockedOnTarget"
    names(scrapedDefenseFrame)[28] = "PassesBlocked"
    names(scrapedDefenseFrame)[29] = "Interception"
    names(scrapedDefenseFrame)[31] = "Clearances"
    names(scrapedDefenseFrame)[32] = "Errors"
    
    
    scrapedDefenseFrame = scrapedDefenseFrame %>% 
      select(2:29,31,32) %>% 
      filter(Player != "Player")
    
    scrapedDefenseFrame = scrapedDefenseFrame %>% mutate_each(funs(empty_as_zero))
    
  }
  cleanPlayingTime = function(scrapedPlayingTime){
    names(scrapedPlayingTime)[2] = "Player"
    names(scrapedPlayingTime)[3] = "Nation"
    names(scrapedPlayingTime)[4] = "Position"
    names(scrapedPlayingTime)[5] = "Team"
    names(scrapedPlayingTime)[6] = "League"
    names(scrapedPlayingTime)[7] = "Age"
    names(scrapedPlayingTime)[8] = "BirthYear"
    names(scrapedPlayingTime)[10] = "Min"
    names(scrapedPlayingTime)[14] = "Starts"
    
    scrapedPlayingTime = scrapedPlayingTime[-1,]
    
    scrapedPlayingTime = scrapedPlayingTime %>% select(2:8,10,14)
    scrapedPlayingTime = scrapedPlayingTime %>% filter(Player!="Player")
    scrapedPlayingTime$Min = gsub(",","",scrapedPlayingTime$Min)
    scrapedPlayingTime = scrapedPlayingTime %>% filter(Min!="0", Min!=0)
    return(scrapedPlayingTime)
  }
  cleanPassTypes = function(scrapedPassTypes){
    names(scrapedPassTypes)[2] = "Player"
    names(scrapedPassTypes)[3] = "Nation"
    names(scrapedPassTypes)[4] = "Position"
    names(scrapedPassTypes)[5] = "Team"
    names(scrapedPassTypes)[6] = "League"
    names(scrapedPassTypes)[7] = "Age"
    names(scrapedPassTypes)[8] = "BirthYear"
    names(scrapedPassTypes)[9] = "NinetiesPlayed"
    names(scrapedPassTypes)[11] = "LivePasses"
    names(scrapedPassTypes)[15] = "PassPress"
    
    scrapedPassTypes = scrapedPassTypes %>% select(2:9,11,15)
    scrapedPassTypes = scrapedPassTypes[-1,]
    scrapedPassTypes = scrapedPassTypes %>% filter(Player!="Player")
    return(scrapedPassTypes)
  }
  cleanMisc = function(scrapedMisc){
    names(scrapedMisc)[2] = "Player"
    names(scrapedMisc)[3] = "Nation"
    names(scrapedMisc)[4] = "Position"
    names(scrapedMisc)[5] = "Team"
    names(scrapedMisc)[6] = "League"
    names(scrapedMisc)[7] = "Age"
    names(scrapedMisc)[8] = "BirthYear"
    names(scrapedMisc)[9] = "NinetiesPlayed"
    names(scrapedMisc)[14] = "Fld"
    names(scrapedMisc)[19] = "PKWon"
    names(scrapedMisc)[22] = "Recov"
    
    
    scrapedMisc = scrapedMisc %>% select(2:9,14,19,22)
    scrapedMisc = scrapedMisc[-1,]
    scrapedMisc = scrapedMisc %>% filter(Player!="Player")
    return(scrapedMisc)
  }
  
  
  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###
  statTypes = c("passing", "shooting", "defense", "possession", "misc")
  availableSeasons = c("2017-2018", "2018-2019", "2019-2020", "2020-2021")
  
  if(unique(seasonList %in% availableSeasons)[1] == TRUE & 
     is.na(unique(seasonList %in% availableSeasons)[2])==TRUE ){
    passingTables = data.frame()
    shootingTables = data.frame()
    possessionTables = data.frame()
    defenseTables = data.frame()
    miscTables = data.frame()
    for (h in 1:length(seasonList)) {
      for (i in 1:length(statTypes)) {
        print(paste("Now Scraping", unique(statTypes)[i], "Stats from", unique(seasonList)[h], sep = " "))
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
        season = unique(seasonList)[h]
        statType = unique(statTypes)[i]
        statType2 = paste("stats_",unique(statTypes)[i], sep = "")
        playerOrTeam = "players"
        url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
        paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
        fullURL = paste(paste1, statType2, sep = "")
        
        page <- 
          read_html(fullURL)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        if(statType == "passing"){
          passingTable = cleanPassing(table) %>% mutate(Season = unique(seasonList)[h])
          passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
          passingTables = rbind(passingTables, passingTable)
        }
        
        if(statType == "shooting"){
          shootingTable = cleanShooting(table) %>% mutate(Season = unique(seasonList)[h])
          shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
          shootingTables = rbind(shootingTables, shootingTable)
        }
        
        if(statType == "possession"){
          possessionTable = cleanPossession(table) %>% mutate(Season = unique(seasonList)[h])
          possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
          possessionTables = rbind(possessionTables, possessionTable)
        }
        if(statType == "defense"){
          defenseTable = cleanDefense(table) %>% mutate(Season = unique(seasonList)[h])
          defenseTables = rbind(defenseTables, defenseTable)
        }
        if(statType == "misc"){
          miscTable = cleanMisc(table) %>% mutate(Season = unique(seasonList)[h])
          miscTables = rbind(miscTables, miscTable)
        }
      }
    }
    
    playingTimeTables = data.frame()
    for (j in 1:length(seasonList)) {
      print(j)
      url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
      season = unique(seasonList)[j]
      statType = "playingtime"
      statType2 = "stats_playing_time"
      playerOrTeam = "players"
      url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
      paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
      fullURL = paste(paste1, statType2, sep = "")
      
      page <- 
        read_html(fullURL)
      table <- page %>% html_table()
      table <- table[[1]] 
      
      playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = unique(seasonList)[j])
      playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
      playingTimeTables = rbind(playingTimeTables, playingTimeTable)
    }
    playingTimeTables = playingTimeTables %>% filter(Min!="0")
    
    passTypeTables = data.frame()
    for (k in 1:length(seasonList)) {
      print(k)
      
      url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/Big5"
      season = unique(seasonList)[k]
      statType = "passing_types"
      statType2 = "stats_passing_types"
      playerOrTeam = "players"
      url2 = paste(season, "Big-5-European-Leagues-Stats&content_selector_id=%23",sep = "-")
      paste1 = paste(url1,season,statType, playerOrTeam, url2, sep = "/")
      fullURL = paste(paste1, statType2, sep = "")
      
      page <- 
        read_html(fullURL)
      table <- page %>% html_table()
      table <- table[[1]] 
      
      passTypeTable = cleanPassTypes(table) %>% mutate(Season = unique(seasonList)[k])
      passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
      passTypeTables = rbind(passTypeTables, passTypeTable)
    }
    
    frame = left_join(passingTables, shootingTables, 
                      by = c("Player", "Nation", "Position", "Team", 
                             "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
      left_join(possessionTables, 
                by = c("Player", "Nation", "Position", "Team", 
                       "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
      left_join(defenseTables, 
                by = c("Player", "Nation", "Position", "Team", 
                       "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
      left_join(passTypeTables, 
                by = c("Player", "Nation", "Position", "Team", 
                       "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>%
      left_join(miscTables, 
                by = c("Player", "Nation", "Position", "Team", 
                       "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
      left_join(playingTimeTables, by = c("Player", "Nation", "Position", "Team", 
                                          "League", "Age", "BirthYear", "Season"))
    
    frameInfo = frame %>% select(Player, Nation,Position, Team, League, Season)
    frameMutate = frame %>% select(-names(frameInfo))
    frameMutate = frameMutate %>% 
      mutate_all(funs(as.numeric(.)))
    frame = cbind.data.frame(frameInfo, frameMutate)
    
    return(frame)
  }
  else{
    return(print("Seasons Entered Not Correct"))
  }
}


#Europe - Past Years
pastYearsEurope = function(){
  pastYearsEurope = rbind(pastYearsEurope1,pastYearsEurope2, pastYearsEurope3)
  write.csv(pastYearsEurope, "PastYearsEurope.csv")
}

pastYearsMLS = function(){
  setwd("~/ShinyAlph")
  scrapeMLS = function(seasonList){
    currentSeason = "2020"
    require(rvest)
    require(dplyr)
    empty_as_zero <- function(x){
      if("factor" %in% class(x)) x <- as.character(x) ## since ifelse wont work with factors
      ifelse(as.character(x)!="", x, 0)
    }
    cleanShooting = function(frame){
      
      names(frame)[1]="Rank"
      names(frame)[2]="Player"
      names(frame)[3]="Nation"
      names(frame)[4]="Position"
      names(frame)[5]="Team"
      names(frame)[6]="Age"
      names(frame)[7]="BirthYear"
      names(frame)[8]="NinetiesPlayed"
      names(frame)[9]="Goals"
      names(frame)[10]="Shots"
      names(frame)[11]="ShotsOnTarget"
      names(frame)[12]="ShotOnTargetPercent"
      names(frame)[19] = "PKatt"
      names(frame)[20] = "xG"
      names(frame)[21] = "nonPenaltyxG"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      frame = frame %>% select(2:12, 19:21)
      
      frame = frame %>% 
        mutate(ShotOnTargetPercent = ifelse(ShotsOnTarget==0,0,ShotOnTargetPercent))
      
      return(frame)
      
    }
    cleanPassing = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "Age"
      names(frame)[7] = "BirthYear"
      names(frame)[8] = "NinetiesPlayed"
      names(frame)[9] = "PassesCompleted"
      names(frame)[10] = "PassesAttempted"
      names(frame)[11] = "PassCompletionPercentage"
      names(frame)[12] = "TotalPassingDistance"
      names(frame)[13] = "PassPrgDist"
      names(frame)[14] = "ShPassesCompleted"
      names(frame)[15] = "ShPassAtt"
      names(frame)[16] = "SortPassCompletionPercentage"
      names(frame)[17] = "MedPassesCompleted"
      names(frame)[18] = "MedPassesAttempted"
      names(frame)[19] = "MedPassCompletionPercentage"
      names(frame)[20] = "LongPassesCompleted"
      names(frame)[21] = "LngPassAtt"
      names(frame)[22] = "LongPassCompletionPercentage"
      names(frame)[24] = "xA"
      names(frame)[26] = "KeyPasses"
      names(frame)[27] = "PassesThatEnterFinalThird"
      names(frame)[28] = "PPA"
      names(frame)[29] = "CrsPA"
      names(frame)[30] = "ProgPasses"
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:22, 24,26:30)
      
      return(frame)
    }
    cleanPossession = function(frame){
      
      names(frame)[2] = "Player"
      names(frame)[3] = "Nation"
      names(frame)[4] = "Position"
      names(frame)[5] = "Team"
      names(frame)[6] = "Age"
      names(frame)[7] = "BirthYear"
      names(frame)[8] = "NinetiesPlayed"
      names(frame)[9] = "Touches"
      names(frame)[10] = "DefensivePenaltyAreaTouches"
      names(frame)[11] = "DefensiveThirdTouches"
      names(frame)[12] = "MiddleThirdTouches"
      names(frame)[13] = "AttackingThirdTouches"
      names(frame)[14] = "AttackingPenaltyAreaTouches"
      names(frame)[16] = "SuccessfulDribbles"
      names(frame)[17] = "DribblesAttempted"
      names(frame)[18] = "DribbleSuccessPercent"
      names(frame)[19] = "TotalPlayersDribbledPast"
      names(frame)[21] = "TotalCarries"
      names(frame)[22] = "TotalCarryDistance"
      names(frame)[23] = "TotalCarryProgressiveDistance"
      names(frame)[24] = "NumTimesTarget"
      names(frame)[25] = "TotalPassesReceived"
      
      
      frame = frame[-1,]
      
      frame = frame[which(frame$Player != "Player"),]
      
      frame = frame %>% select(2:14,16,17,18,19,21:25)
      
      return(frame)
    }
    cleanDefense = function(scrapedDefenseFrame){
      names(scrapedDefenseFrame)[2] = "Player"
      names(scrapedDefenseFrame)[3] = "Nation"
      names(scrapedDefenseFrame)[4] = "Position"
      names(scrapedDefenseFrame)[5] = "Team"
      names(scrapedDefenseFrame)[6] = "Age"
      names(scrapedDefenseFrame)[7] = "BirthYear"
      names(scrapedDefenseFrame)[8] = "NinetiesPlayed"
      names(scrapedDefenseFrame)[9] = "TotalTackles"
      names(scrapedDefenseFrame)[10] = "TacklesWon"
      names(scrapedDefenseFrame)[11] = "DefThirdTacklesWon"
      names(scrapedDefenseFrame)[12] = "MidThirdTacklesWon"
      names(scrapedDefenseFrame)[13] = "AttThirdTacklesWon"
      names(scrapedDefenseFrame)[14] = "TacklesAgainstDribblesWon"
      names(scrapedDefenseFrame)[15] = "DribblesAgainst"
      names(scrapedDefenseFrame)[16] = "DribbleTackledPercentage"
      names(scrapedDefenseFrame)[17] = "DribbledPast"
      names(scrapedDefenseFrame)[18] = "TotalPressures"
      names(scrapedDefenseFrame)[19] = "SuccessfulPressures"
      names(scrapedDefenseFrame)[20] = "SuccessfulPressurePercent"
      names(scrapedDefenseFrame)[21] = "DefThirdPressures"
      names(scrapedDefenseFrame)[22] = "MidThirdPressures"
      names(scrapedDefenseFrame)[23] = "AttThirdPressures"
      names(scrapedDefenseFrame)[24] = "TotalBlocks"
      names(scrapedDefenseFrame)[25] = "ShotsBlocked"
      names(scrapedDefenseFrame)[26] = "ShotsBlockedOnTarget"
      names(scrapedDefenseFrame)[27] = "PassesBlocked"
      names(scrapedDefenseFrame)[28] = "Interception"
      names(scrapedDefenseFrame)[30] = "Clearances"
      names(scrapedDefenseFrame)[31] = "Errors"
      
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% 
        select(2:28,30,31) %>% 
        filter(Player != "Player")
      
      scrapedDefenseFrame = scrapedDefenseFrame %>% mutate_each(funs(empty_as_zero))
      
    }
    cleanPlayingTime = function(scrapedPlayingTime){
      names(scrapedPlayingTime)[2] = "Player"
      names(scrapedPlayingTime)[3] = "Nation"
      names(scrapedPlayingTime)[4] = "Position"
      names(scrapedPlayingTime)[5] = "Team"
      names(scrapedPlayingTime)[6] = "Age"
      names(scrapedPlayingTime)[7] = "BirthYear"
      names(scrapedPlayingTime)[9] = "Min"
      names(scrapedPlayingTime)[13] = "Starts"
      
      scrapedPlayingTime = scrapedPlayingTime[-1,]
      
      scrapedPlayingTime = scrapedPlayingTime %>% select(2:7,9,13)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Player!="Player")
      scrapedPlayingTime$Min = gsub(",","",scrapedPlayingTime$Min)
      scrapedPlayingTime = scrapedPlayingTime %>% filter(Min!="0", Min!=0)
      return(scrapedPlayingTime)
    }
    cleanPassTypes = function(scrapedPassTypes){
      names(scrapedPassTypes)[2] = "Player"
      names(scrapedPassTypes)[3] = "Nation"
      names(scrapedPassTypes)[4] = "Position"
      names(scrapedPassTypes)[5] = "Team"
      names(scrapedPassTypes)[6] = "Age"
      names(scrapedPassTypes)[7] = "BirthYear"
      names(scrapedPassTypes)[8] = "NinetiesPlayed"
      names(scrapedPassTypes)[10] = "LivePasses"
      names(scrapedPassTypes)[14] = "PassPress"
      
      scrapedPassTypes = scrapedPassTypes %>% select(2:8,10,14)
      scrapedPassTypes = scrapedPassTypes[-1,]
      scrapedPassTypes = scrapedPassTypes %>% filter(Player!="Player")
      return(scrapedPassTypes)
    }
    cleanMisc = function(scrapedMisc){
      names(scrapedMisc)[2] = "Player"
      names(scrapedMisc)[3] = "Nation"
      names(scrapedMisc)[4] = "Position"
      names(scrapedMisc)[5] = "Team"
      names(scrapedMisc)[6] = "Age"
      names(scrapedMisc)[7] = "BirthYear"
      names(scrapedMisc)[8] = "NinetiesPlayed"
      names(scrapedMisc)[13] = "Fld"
      names(scrapedMisc)[18] = "PKWon"
      names(scrapedMisc)[21] = "Recov"
      
      
      scrapedMisc = scrapedMisc %>% select(2:8,13,18,21)
      scrapedMisc = scrapedMisc[-1,]
      scrapedMisc = scrapedMisc %>% filter(Player!="Player")
      return(scrapedMisc)
    }
    
    
    ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###  ###
    statTypes = c("passing", "shooting", "defense", "possession", "misc")
    availableSeasons = c("2018", "2019", "2020")
    if(unique(seasonList %in% availableSeasons)[1] == TRUE & 
       is.na(unique(seasonList %in% availableSeasons)[2])==TRUE){
      
      passingTables = data.frame()
      shootingTables = data.frame()
      possessionTables = data.frame()
      defenseTables = data.frame()
      miscTables = data.frame()
      playingTimeTables = data.frame()
      passTypeTables = data.frame()
      
      
      if(seasonList!="2020"){
        seasonListWithoutCurrentSeason = seasonList[seasonList != currentSeason]
        for (h in 1:length(seasonListWithoutCurrentSeason)) {
          for (i in 1:length(statTypes)) {
            print(paste("Now Scraping", unique(statTypes)[i], "Stats from", unique(seasonListWithoutCurrentSeason)[h], sep = " "))
            url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
            season = unique(seasonListWithoutCurrentSeason)[h]
            statType = unique(statTypes)[i]
            statType2 = paste("stats",unique(statTypes)[i],sep="_")
            
            code = ifelse(season==2019, "2798","1759")
            paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
            url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
            
            page <- 
              read_html(url2)
            table <- page %>% html_table()
            table <- table[[1]] 
            
            if(statType == "passing"){
              passingTable = cleanPassing(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
              passingTables = rbind(passingTables, passingTable)
            }
            
            if(statType == "shooting"){
              shootingTable = cleanShooting(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
              shootingTables = rbind(shootingTables, shootingTable)
            }
            
            if(statType == "possession"){
              possessionTable = cleanPossession(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
              possessionTables = rbind(possessionTables, possessionTable)
            }
            if(statType == "defense"){
              defenseTable = cleanDefense(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              defenseTables = rbind(defenseTables, defenseTable)
            }
            if(statType == "misc"){
              miscTable = cleanMisc(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[h]) %>% mutate(League = "MLS")
              miscTables = rbind(miscTables, miscTable)
            }
            
          }
        }
        
        
        
        playingTimeTables = data.frame()
        for (j in 1:length(seasonListWithoutCurrentSeason)) {
          print(paste("Now Scraping Playing Time From", unique(seasonListWithoutCurrentSeason)[j], sep = " "))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          season = unique(seasonListWithoutCurrentSeason)[j]
          statType = "playingtime"
          statType2 = "stats_playing_time"
          
          code = ifelse(season==2019, "2798","1759")
          paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          
          playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = unique(seasonListWithoutCurrentSeason)[j]) %>% mutate(League = "MLS")
          playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
          playingTimeTables = rbind(playingTimeTables, playingTimeTable)
          
        }
        #playingTimeTables = playingTimeTables %>% filter(Min!="0")
        
        passTypeTables = data.frame()
        for (k in 1:length(seasonListWithoutCurrentSeason)) {
          print(paste("Now Scraping Pass Types from ", unique(seasonList)[k]))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          season = unique(seasonListWithoutCurrentSeason)[k]
          statType = "passing_types"
          statType2 = "stats_passing_types"
          
          code = ifelse(season==2019, "2798","1759")
          paste1 = paste(url1,code,statType, "2019-Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          passTypeTable = cleanPassTypes(table) %>% mutate(Season = unique(seasonList)[k]) %>% mutate(League = "MLS")
          passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
          passTypeTables = rbind(passTypeTables, passTypeTable)
          
        }
        
      }
      if(currentSeason %in% seasonList){
        for (z in 1:length(statTypes)) {
          print(paste("Now Scraping", unique(statTypes)[z], "Stats from Current Season", sep = " "))
          url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
          statType = unique(statTypes)[z]
          statType2 = paste("stats_", statType, sep = "")
          paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
          url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
          
          page <- 
            read_html(url2)
          table <- page %>% html_table()
          table <- table[[1]] 
          
          if(statType == "passing"){
            passingTable = cleanPassing(table) %>% 
              mutate(Season = currentSeason) %>% mutate(League = "MLS")
            passingTable = passingTable %>% mutate_each(funs(empty_as_zero))
            passingTables = rbind(passingTables, passingTable)
          }
          
          if(statType == "shooting"){
            shootingTable = cleanShooting(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            shootingTable = shootingTable %>% mutate_each(funs(empty_as_zero))
            shootingTables = rbind(shootingTables, shootingTable)
          }
          
          if(statType == "possession"){
            possessionTable = cleanPossession(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            possessionTable = possessionTable %>% mutate_each(funs(empty_as_zero))
            possessionTables = rbind(possessionTables, possessionTable)
          }
          if(statType == "defense"){
            defenseTable = cleanDefense(table) %>% mutate(Season =currentSeason) %>% mutate(League = "MLS")
            defenseTables = rbind(defenseTables, defenseTable)
          }
          if(statType == "misc"){
            miscTable = cleanMisc(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
            miscTables = rbind(miscTables, miscTable)
          }
        }
        
        
        print("Now Scraping Playing Time from Current Season")
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
        statType = "playingtime"
        statType2 = "stats_playing_time"
        paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
        url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
        
        page <- 
          read_html(url2)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        
        playingTimeTable = cleanPlayingTime(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
        playingTimeTable = playingTimeTable %>% mutate_each(funs(empty_as_zero))
        playingTimeTables = rbind(playingTimeTables, playingTimeTable)
        playingTimeTables = playingTimeTables %>% filter(Min!=0, Min!="0")
        
        print("Now Scraping Pass Types from Current Season")
        url1 =  "http://acciotables.herokuapp.com/?page_url=https://fbref.com/en/comps/22"
        statType = "passing_types"
        statType2 = "stats_passing_types"
        paste1 = paste(url1,statType, "Major-League-Soccer-Stats", sep = "/")
        url2 = paste(paste1, "&content_selector_id=%23",statType2, sep = "")
        page <- 
          read_html(url2)
        table <- page %>% html_table()
        table <- table[[1]] 
        
        passTypeTable = cleanPassTypes(table) %>% mutate(Season = currentSeason) %>% mutate(League = "MLS")
        passTypeTable = passTypeTable %>% mutate_each(funs(empty_as_zero))
        passTypeTables = rbind(passTypeTables, passTypeTable)
        
        
      }
      
      
      frame = left_join(passingTables, shootingTables, 
                        by = c("Player", "Nation", "Position", "Team", 
                               "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(possessionTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(defenseTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(passTypeTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>%
        left_join(miscTables, 
                  by = c("Player", "Nation", "Position", "Team", 
                         "League", "Age", "BirthYear", "NinetiesPlayed", "Season")) %>% 
        left_join(playingTimeTables, by = c("Player", "Nation", "Position", "Team", 
                                            "League", "Age", "BirthYear", "Season"))
      
      frameInfo = frame %>% select(Player, Nation,Position, Team, League, Season)
      frameMutate = frame %>% select(-names(frameInfo))
      frameMutate = frameMutate %>% 
        mutate_all(funs(as.numeric(.)))
      frame = cbind.data.frame(frameInfo, frameMutate)
      
      return(frame)
    }
    
    else{
      return(print("Seasons Entered Not Correct"))
    }
  }
  previousYearsMLSData = scrapeMLS(c("2018","2019"))
  write.csv(previousYearsMLSData,"previousYearsMLSData.csv")

  
}

##########################################################################################
##########################################################################################
updateMLS()
updateEurope()

##########################################################################################
#################################################
#pastYearsEurope1 = bigFiveScraper(c("2017-2018"))
#pastYearsEurope2 = bigFiveScraper(c("2018-2019"))
#pastYearsEurope3 = bigFiveScraper(c("2019-2020"))
#################################################
#pastYearsEurope()
#pastYearsMLS()

