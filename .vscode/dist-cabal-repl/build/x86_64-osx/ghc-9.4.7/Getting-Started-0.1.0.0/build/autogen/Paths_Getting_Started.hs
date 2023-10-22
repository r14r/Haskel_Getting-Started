{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_Getting_Started (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/bin"
libdir     = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/lib/x86_64-osx-ghc-9.4.7/Getting-Started-0.1.0.0-inplace"
dynlibdir  = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/lib/x86_64-osx-ghc-9.4.7"
datadir    = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/share/x86_64-osx-ghc-9.4.7/Getting-Started-0.1.0.0"
libexecdir = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/libexec/x86_64-osx-ghc-9.4.7/Getting-Started-0.1.0.0"
sysconfdir = "/Users/Shared/CLOUD/Programmier-Workshops/Kurse/Haskell/.venv/haskell/.cabal/etc"

getBinDir     = catchIO (getEnv "Getting_Started_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "Getting_Started_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "Getting_Started_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "Getting_Started_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Getting_Started_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Getting_Started_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
