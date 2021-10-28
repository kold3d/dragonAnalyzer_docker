{
    gSystem->Load("/root/packages/dragon/analyzer/lib/libDragon.so");
    gInterpreter->AddIncludePath("/root/packages/dragon/analyzer/src/");
    gInterpreter->AddIncludePath("/root/packages/dragon/analyzer/src/midas/");
    gInterpreter->AddIncludePath("/root/packages/dragon/analyzer/src/midas/libMidasInterface/");
}
