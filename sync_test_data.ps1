$LOCAL_COPY_DIR = "local"

$INSTRUCTIONS_URL="https://github.com/Unidata/thredds-test-data"

$RSYNC_SERVER="rsync://sync.unidata.ucar.edu/thredds-test-data/"

$TOP_LEVEL_DATA_DIR = (Get-Location).path
$FULL_TEST_DATA_PATH="$TOP_LEVEL_DATA_DIR\$LOCAL_COPY_DIR\thredds-test-data"

if ((Get-Command "rsync.exe" -ErrorAction SilentlyContinue) -eq $null) { 
   Write-Host "Unable to find rsync.exe in your PATH"
   Write-Host "Please download DeltaCopy and follow the instructions at $INSTRUCTIONS_URL"
} else {
  Write-Host ""
  if (-not (Test-Path $LOCAL_COPY_DIR)) {
    $BANNER="##################################################"
    for ($i=0; $i -le $LOCAL_COPY_DIR.length; $i++) {
      $BANNER="$BANNER#"
    }
    Write-Host "$BANNER"
    Write-Host "# Starting initial sync of THREDDS test data to $LOCAL_COPY_DIR/ #"
    Write-Host "$BANNER"
  } else {
    Write-Host "###############################################"
    Write-Host "# Syncing local copy of the THREDDS test data #"
    Write-Host "###############################################"
  }
  rsync.exe --archive --verbose --delete $RSYNC_SERVER $LOCAL_COPY_DIR
  Write-Host ""
  Write-Host "#############"
  Write-Host "# Finished! #"
  Write-Host "#############"
}

# For the THREDDS projects and gradle, use forward slashes in path
$FULL_TEST_DATA_PATH=$FULL_TEST_DATA_PATH.Replace("\", "/")

Write-Host ""
Write-Host "To ensure the netcdf-java or TDS tests know where the test data live, do one of the following:"
Write-Host "1. Set the location in ~/.gradle/gradle.properties:"
Write-Host ""
Write-Host "  # For tests annotated with NeedsCdmUnitTest"
Write-Host "  systemProp.unidata.testdata.path=$FULL_TEST_DATA_PATH"
Write-Host ""
Write-Host "2. Set the location from the command line when running gradle for a single test:"
Write-Host ""
Write-Host "  ./gradlew -D""unidata.testdata.path""=$FULL_TEST_DATA_PATH :cdm-test:test --tests ucar.nc2.ft.coverage.TestCoverageCurvilinear"
Write-Host ""
Write-Host "Note: On Windows, we use the ""/"" path separator instead of the more familiar ""\"" separator"
Write-Host ""
Write-Host "Happy Testing!"
Write-Host ""

