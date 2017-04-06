public protocol NodeChangedDelegate {
    func didChange(sender: NodeView)
    func select(sender: NodeView)
    func endChange()
}
