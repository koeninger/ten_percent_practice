module SemVer where

import Text.Trifecta
import Control.Applicative

data NumberOrString
  = NOSS String
  | NOSI Integer
  deriving (Eq, Show)

type Major = Integer
type Minor = Integer
type Patch = Integer
type Release = [NumberOrString]
type Metadata = [NumberOrString]

data SemVer = SemVer Major Minor Patch Release Metadata deriving (Eq, Show)

parseSemVer :: Parser SemVer
parseSemVer = do
  maj <- integer
  char '.'
  min <- integer
  char '.'
  pat <- integer
  rel <- parseRelease <|> return []
  met <- parseMetadata <|> return []
  return $ SemVer maj min pat met rel

parseNOS :: Parser NumberOrString
parseNOS =
  ((NOSI <$> integer) <|>
   (NOSS <$> some letter)) <*
  ((char '.') <|> return ' ')

parseRelease :: Parser Release
parseRelease =
  (char '-') *> (many parseNOS)

parseMetadata :: Parser Metadata
parseMetadata =
  (char '+') *> (many parseNOS)

main :: IO ()
main = do
  print $ parseString parseSemVer mempty "2.1.1"
  print $ parseString parseSemVer mempty "1.0.0-x.7.z.92"

instance Ord SemVer where
  compare (SemVer a b c _ _) (SemVer x y z _ _) =
    if a /= x
    then compare a x
    else if b /= y
         then compare b y
         else compare c z

