import "../../theme" as Tokens

ApolloButton {
    text: ""
    horizontalPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.medium)
    verticalPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.medium)
    cornerRadius: Tokens.Theme.scaled(Tokens.Theme.shapes.circle)

    implicitWidth: Tokens.Theme.scaled(Tokens.Theme.spacing.minimumTouchTarget)
    implicitHeight: implicitWidth
}
