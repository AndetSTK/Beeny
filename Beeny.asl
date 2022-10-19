state("Beeny") {}
startup
{
    Assembly.Load(File.ReadAllBytes(@"Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
}

init
{
    vars.Helper.TryLoadTimeout = 200;
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["interactable"] = mono.Make<int>("GameManager", "instance", "interactable");
        vars.Helper["currentSlot"] = mono.MakeString("SaveManager", "instance", "currentSlot");
        return true;
    });
}

update
{
    current.SceneName = vars.Helper.Scenes.Active.Name;
}

start
{
    return (current.SceneName != "SaveStatesMenu" && old.SceneName == "SaveStatesMenu");
}

split
{
    return ((current.interactable == 0 && old.interactable != 0) || (current.SceneName == "Credits" && old.SceneName != "Credits"));
}
