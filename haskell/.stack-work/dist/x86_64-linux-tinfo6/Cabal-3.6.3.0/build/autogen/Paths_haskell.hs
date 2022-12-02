{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_haskell (
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
bindir     = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/bin"
libdir     = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/lib/x86_64-linux-ghc-9.2.5/haskell-0.1.0.0-D78nyr6JwDM5hZv6gSTwaP"
dynlibdir  = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/lib/x86_64-linux-ghc-9.2.5"
datadir    = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/share/x86_64-linux-ghc-9.2.5/haskell-0.1.0.0"
libexecdir = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/libexec/x86_64-linux-ghc-9.2.5/haskell-0.1.0.0"
sysconfdir = "/home/abhs/dev/aoc/2022/haskell/.stack-work/install/x86_64-linux-tinfo6/7b7a7206b6f4a15277304b94c36e026c62d1e7a641e0d185b3610167cb3399d8/9.2.5/etc"

getBinDir     = catchIO (getEnv "haskell_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "haskell_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "haskell_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "haskell_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_sysconfdir") (\_ -> return sysconfdir)




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
