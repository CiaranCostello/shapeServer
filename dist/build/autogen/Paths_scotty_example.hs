module Paths_scotty_example (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/inn1t-f00s/.cabal/bin"
libdir     = "/home/inn1t-f00s/.cabal/lib/x86_64-linux-ghc-7.10.2/scotty-example-0.1.0.0-J7AcQLscMExBQERnGV3UPp"
datadir    = "/home/inn1t-f00s/.cabal/share/x86_64-linux-ghc-7.10.2/scotty-example-0.1.0.0"
libexecdir = "/home/inn1t-f00s/.cabal/libexec"
sysconfdir = "/home/inn1t-f00s/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "scotty_example_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "scotty_example_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "scotty_example_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "scotty_example_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "scotty_example_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
