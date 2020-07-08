##---------------------------------------------------------------------------##
## Constants                                                                 ##
##---------------------------------------------------------------------------##
PLAYGROUND_DIR="$HOME/_playground";


##---------------------------------------------------------------------------##
## Functions                                                                 ##
##---------------------------------------------------------------------------##
##-----------------------------------------------------------------------------
pg() 
{
    mkdir -p "$PLAYGROUND_DIR";
    cd $PLAYGROUND_DIR;  
}

##-----------------------------------------------------------------------------
playground()
{
    pg; 
}