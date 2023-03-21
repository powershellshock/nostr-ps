function Update-NostrEventHash {
    Param($NostrEvt)

    $NostrEvt.id = '1234567890abcdef1234567890abcdef'
    
    $NostrEvt
}