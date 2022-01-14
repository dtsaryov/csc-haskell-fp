import Data.Time.Clock
import Data.Time.Format

timeToString :: UTCTime -> String
timeToString = formatTime defaultTimeLocale "%a %d %T"

data LogLevel = Error | Warning | Info deriving Show

data LogEntry = LogEntry {
  timestamp :: UTCTime,
  logLevel  :: LogLevel,
  message   :: String
}

logLevelToString :: LogLevel -> String
logLevelToString = show

logEntryToString :: LogEntry -> String
logEntryToString le = time ++ ": " ++ level ++ ": " ++ msg where
  time  = timeToString $ timestamp le
  level = show $ logLevel le
  msg   = message le

data Person = Person { firstName :: String, lastName :: String, age :: Int } deriving Show

updateLastName :: Person -> Person -> Person
updateLastName person1 person2 = person2 {lastName = lastName person1}

abbrFirstName :: Person -> Person
abbrFirstName p = p {firstName = abbr $ firstName p} where
  abbr ([]) = ""
  abbr (x:[]) = [x]
  abbr (x:xs) = x : "."