# Click-Frontend

CoffeeChats can pair students with similar interests to then set up a "coffee chat."

1.) The user creates a profile with an email and password, which is stored using firebase.
2.) The user then creates a profile and adds interests.
3.) The user refreshes the tile screen and can view their recent matches.

We unfortunately ran out of time so I included a fourth screenshot of hardcoded data. The goal was to set up firebase chat, but currently you can only connect through trading NetIds.

The tiles that display students are in a UICollectionView.
There are four networking methods in NetworkManager.swift
Three are used and getAllUsers was used for the dummy data while making the UI.
