module Spa.Generated.Pages exposing
    ( Model
    , Msg
    , init
    , load
    , save
    , subscriptions
    , update
    , view
    )

import Pages.Top
import Pages.Day1
import Pages.Day10
import Pages.Day11
import Pages.Day12
import Pages.Day13
import Pages.Day14
import Pages.Day15
import Pages.Day16
import Pages.Day17
import Pages.Day18
import Pages.Day19
import Pages.Day2
import Pages.Day20
import Pages.Day21
import Pages.Day22
import Pages.Day23
import Pages.Day24
import Pages.Day25
import Pages.Day26
import Pages.Day27
import Pages.Day28
import Pages.Day29
import Pages.Day3
import Pages.Day30
import Pages.Day4
import Pages.Day5
import Pages.Day6
import Pages.Day7
import Pages.Day8
import Pages.Day9
import Pages.NotFound
import Pages.PageA
import Pages.PageB
import Shared
import Spa.Document as Document exposing (Document)
import Spa.Generated.Route as Route exposing (Route)
import Spa.Page exposing (Page)
import Spa.Url as Url


-- TYPES


type Model
    = Top__Model Pages.Top.Model
    | Day1__Model Pages.Day1.Model
    | Day10__Model Pages.Day10.Model
    | Day11__Model Pages.Day11.Model
    | Day12__Model Pages.Day12.Model
    | Day13__Model Pages.Day13.Model
    | Day14__Model Pages.Day14.Model
    | Day15__Model Pages.Day15.Model
    | Day16__Model Pages.Day16.Model
    | Day17__Model Pages.Day17.Model
    | Day18__Model Pages.Day18.Model
    | Day19__Model Pages.Day19.Model
    | Day2__Model Pages.Day2.Model
    | Day20__Model Pages.Day20.Model
    | Day21__Model Pages.Day21.Model
    | Day22__Model Pages.Day22.Model
    | Day23__Model Pages.Day23.Model
    | Day24__Model Pages.Day24.Model
    | Day25__Model Pages.Day25.Model
    | Day26__Model Pages.Day26.Model
    | Day27__Model Pages.Day27.Model
    | Day28__Model Pages.Day28.Model
    | Day29__Model Pages.Day29.Model
    | Day3__Model Pages.Day3.Model
    | Day30__Model Pages.Day30.Model
    | Day4__Model Pages.Day4.Model
    | Day5__Model Pages.Day5.Model
    | Day6__Model Pages.Day6.Model
    | Day7__Model Pages.Day7.Model
    | Day8__Model Pages.Day8.Model
    | Day9__Model Pages.Day9.Model
    | NotFound__Model Pages.NotFound.Model
    | PageA__Model Pages.PageA.Model
    | PageB__Model Pages.PageB.Model


type Msg
    = Top__Msg Pages.Top.Msg
    | Day1__Msg Pages.Day1.Msg
    | Day10__Msg Pages.Day10.Msg
    | Day11__Msg Pages.Day11.Msg
    | Day12__Msg Pages.Day12.Msg
    | Day13__Msg Pages.Day13.Msg
    | Day14__Msg Pages.Day14.Msg
    | Day15__Msg Pages.Day15.Msg
    | Day16__Msg Pages.Day16.Msg
    | Day17__Msg Pages.Day17.Msg
    | Day18__Msg Pages.Day18.Msg
    | Day19__Msg Pages.Day19.Msg
    | Day2__Msg Pages.Day2.Msg
    | Day20__Msg Pages.Day20.Msg
    | Day21__Msg Pages.Day21.Msg
    | Day22__Msg Pages.Day22.Msg
    | Day23__Msg Pages.Day23.Msg
    | Day24__Msg Pages.Day24.Msg
    | Day25__Msg Pages.Day25.Msg
    | Day26__Msg Pages.Day26.Msg
    | Day27__Msg Pages.Day27.Msg
    | Day28__Msg Pages.Day28.Msg
    | Day29__Msg Pages.Day29.Msg
    | Day3__Msg Pages.Day3.Msg
    | Day30__Msg Pages.Day30.Msg
    | Day4__Msg Pages.Day4.Msg
    | Day5__Msg Pages.Day5.Msg
    | Day6__Msg Pages.Day6.Msg
    | Day7__Msg Pages.Day7.Msg
    | Day8__Msg Pages.Day8.Msg
    | Day9__Msg Pages.Day9.Msg
    | NotFound__Msg Pages.NotFound.Msg
    | PageA__Msg Pages.PageA.Msg
    | PageB__Msg Pages.PageB.Msg



-- INIT


init : Route -> Shared.Model -> ( Model, Cmd Msg )
init route =
    case route of
        Route.Top ->
            pages.top.init ()
        
        Route.Day1 ->
            pages.day1.init ()
        
        Route.Day10 ->
            pages.day10.init ()
        
        Route.Day11 ->
            pages.day11.init ()
        
        Route.Day12 ->
            pages.day12.init ()
        
        Route.Day13 ->
            pages.day13.init ()
        
        Route.Day14 ->
            pages.day14.init ()
        
        Route.Day15 ->
            pages.day15.init ()
        
        Route.Day16 ->
            pages.day16.init ()
        
        Route.Day17 ->
            pages.day17.init ()
        
        Route.Day18 ->
            pages.day18.init ()
        
        Route.Day19 ->
            pages.day19.init ()
        
        Route.Day2 ->
            pages.day2.init ()
        
        Route.Day20 ->
            pages.day20.init ()
        
        Route.Day21 ->
            pages.day21.init ()
        
        Route.Day22 ->
            pages.day22.init ()
        
        Route.Day23 ->
            pages.day23.init ()
        
        Route.Day24 ->
            pages.day24.init ()
        
        Route.Day25 ->
            pages.day25.init ()
        
        Route.Day26 ->
            pages.day26.init ()
        
        Route.Day27 ->
            pages.day27.init ()
        
        Route.Day28 ->
            pages.day28.init ()
        
        Route.Day29 ->
            pages.day29.init ()
        
        Route.Day3 ->
            pages.day3.init ()
        
        Route.Day30 ->
            pages.day30.init ()
        
        Route.Day4 ->
            pages.day4.init ()
        
        Route.Day5 ->
            pages.day5.init ()
        
        Route.Day6 ->
            pages.day6.init ()
        
        Route.Day7 ->
            pages.day7.init ()
        
        Route.Day8 ->
            pages.day8.init ()
        
        Route.Day9 ->
            pages.day9.init ()
        
        Route.NotFound ->
            pages.notFound.init ()
        
        Route.PageA ->
            pages.pageA.init ()
        
        Route.PageB ->
            pages.pageB.init ()



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update bigMsg bigModel =
    case ( bigMsg, bigModel ) of
        ( Top__Msg msg, Top__Model model ) ->
            pages.top.update msg model
        
        ( Day1__Msg msg, Day1__Model model ) ->
            pages.day1.update msg model
        
        ( Day10__Msg msg, Day10__Model model ) ->
            pages.day10.update msg model
        
        ( Day11__Msg msg, Day11__Model model ) ->
            pages.day11.update msg model
        
        ( Day12__Msg msg, Day12__Model model ) ->
            pages.day12.update msg model
        
        ( Day13__Msg msg, Day13__Model model ) ->
            pages.day13.update msg model
        
        ( Day14__Msg msg, Day14__Model model ) ->
            pages.day14.update msg model
        
        ( Day15__Msg msg, Day15__Model model ) ->
            pages.day15.update msg model
        
        ( Day16__Msg msg, Day16__Model model ) ->
            pages.day16.update msg model
        
        ( Day17__Msg msg, Day17__Model model ) ->
            pages.day17.update msg model
        
        ( Day18__Msg msg, Day18__Model model ) ->
            pages.day18.update msg model
        
        ( Day19__Msg msg, Day19__Model model ) ->
            pages.day19.update msg model
        
        ( Day2__Msg msg, Day2__Model model ) ->
            pages.day2.update msg model
        
        ( Day20__Msg msg, Day20__Model model ) ->
            pages.day20.update msg model
        
        ( Day21__Msg msg, Day21__Model model ) ->
            pages.day21.update msg model
        
        ( Day22__Msg msg, Day22__Model model ) ->
            pages.day22.update msg model
        
        ( Day23__Msg msg, Day23__Model model ) ->
            pages.day23.update msg model
        
        ( Day24__Msg msg, Day24__Model model ) ->
            pages.day24.update msg model
        
        ( Day25__Msg msg, Day25__Model model ) ->
            pages.day25.update msg model
        
        ( Day26__Msg msg, Day26__Model model ) ->
            pages.day26.update msg model
        
        ( Day27__Msg msg, Day27__Model model ) ->
            pages.day27.update msg model
        
        ( Day28__Msg msg, Day28__Model model ) ->
            pages.day28.update msg model
        
        ( Day29__Msg msg, Day29__Model model ) ->
            pages.day29.update msg model
        
        ( Day3__Msg msg, Day3__Model model ) ->
            pages.day3.update msg model
        
        ( Day30__Msg msg, Day30__Model model ) ->
            pages.day30.update msg model
        
        ( Day4__Msg msg, Day4__Model model ) ->
            pages.day4.update msg model
        
        ( Day5__Msg msg, Day5__Model model ) ->
            pages.day5.update msg model
        
        ( Day6__Msg msg, Day6__Model model ) ->
            pages.day6.update msg model
        
        ( Day7__Msg msg, Day7__Model model ) ->
            pages.day7.update msg model
        
        ( Day8__Msg msg, Day8__Model model ) ->
            pages.day8.update msg model
        
        ( Day9__Msg msg, Day9__Model model ) ->
            pages.day9.update msg model
        
        ( NotFound__Msg msg, NotFound__Model model ) ->
            pages.notFound.update msg model
        
        ( PageA__Msg msg, PageA__Model model ) ->
            pages.pageA.update msg model
        
        ( PageB__Msg msg, PageB__Model model ) ->
            pages.pageB.update msg model
        
        _ ->
            ( bigModel, Cmd.none )



-- BUNDLE - (view + subscriptions)


bundle : Model -> Bundle
bundle bigModel =
    case bigModel of
        Top__Model model ->
            pages.top.bundle model
        
        Day1__Model model ->
            pages.day1.bundle model
        
        Day10__Model model ->
            pages.day10.bundle model
        
        Day11__Model model ->
            pages.day11.bundle model
        
        Day12__Model model ->
            pages.day12.bundle model
        
        Day13__Model model ->
            pages.day13.bundle model
        
        Day14__Model model ->
            pages.day14.bundle model
        
        Day15__Model model ->
            pages.day15.bundle model
        
        Day16__Model model ->
            pages.day16.bundle model
        
        Day17__Model model ->
            pages.day17.bundle model
        
        Day18__Model model ->
            pages.day18.bundle model
        
        Day19__Model model ->
            pages.day19.bundle model
        
        Day2__Model model ->
            pages.day2.bundle model
        
        Day20__Model model ->
            pages.day20.bundle model
        
        Day21__Model model ->
            pages.day21.bundle model
        
        Day22__Model model ->
            pages.day22.bundle model
        
        Day23__Model model ->
            pages.day23.bundle model
        
        Day24__Model model ->
            pages.day24.bundle model
        
        Day25__Model model ->
            pages.day25.bundle model
        
        Day26__Model model ->
            pages.day26.bundle model
        
        Day27__Model model ->
            pages.day27.bundle model
        
        Day28__Model model ->
            pages.day28.bundle model
        
        Day29__Model model ->
            pages.day29.bundle model
        
        Day3__Model model ->
            pages.day3.bundle model
        
        Day30__Model model ->
            pages.day30.bundle model
        
        Day4__Model model ->
            pages.day4.bundle model
        
        Day5__Model model ->
            pages.day5.bundle model
        
        Day6__Model model ->
            pages.day6.bundle model
        
        Day7__Model model ->
            pages.day7.bundle model
        
        Day8__Model model ->
            pages.day8.bundle model
        
        Day9__Model model ->
            pages.day9.bundle model
        
        NotFound__Model model ->
            pages.notFound.bundle model
        
        PageA__Model model ->
            pages.pageA.bundle model
        
        PageB__Model model ->
            pages.pageB.bundle model


view : Model -> Document Msg
view =
    bundle >> .view


subscriptions : Model -> Sub Msg
subscriptions =
    bundle >> .subscriptions


save : Model -> Shared.Model -> Shared.Model
save =
    bundle >> .save


load : Model -> Shared.Model -> ( Model, Cmd Msg )
load =
    bundle >> .load



-- UPGRADING PAGES


type alias Upgraded params model msg =
    { init : params -> Shared.Model -> ( Model, Cmd Msg )
    , update : msg -> model -> ( Model, Cmd Msg )
    , bundle : model -> Bundle
    }


type alias Bundle =
    { view : Document Msg
    , subscriptions : Sub Msg
    , save : Shared.Model -> Shared.Model
    , load : Shared.Model -> ( Model, Cmd Msg )
    }


upgrade : (model -> Model) -> (msg -> Msg) -> Page params model msg -> Upgraded params model msg
upgrade toModel toMsg page =
    let
        init_ params shared =
            page.init shared (Url.create params shared.key shared.url) |> Tuple.mapBoth toModel (Cmd.map toMsg)

        update_ msg model =
            page.update msg model |> Tuple.mapBoth toModel (Cmd.map toMsg)

        bundle_ model =
            { view = page.view model |> Document.map toMsg
            , subscriptions = page.subscriptions model |> Sub.map toMsg
            , save = page.save model
            , load = load_ model
            }

        load_ model shared =
            page.load shared model |> Tuple.mapBoth toModel (Cmd.map toMsg)
    in
    { init = init_
    , update = update_
    , bundle = bundle_
    }


pages :
    { top : Upgraded Pages.Top.Params Pages.Top.Model Pages.Top.Msg
    , day1 : Upgraded Pages.Day1.Params Pages.Day1.Model Pages.Day1.Msg
    , day10 : Upgraded Pages.Day10.Params Pages.Day10.Model Pages.Day10.Msg
    , day11 : Upgraded Pages.Day11.Params Pages.Day11.Model Pages.Day11.Msg
    , day12 : Upgraded Pages.Day12.Params Pages.Day12.Model Pages.Day12.Msg
    , day13 : Upgraded Pages.Day13.Params Pages.Day13.Model Pages.Day13.Msg
    , day14 : Upgraded Pages.Day14.Params Pages.Day14.Model Pages.Day14.Msg
    , day15 : Upgraded Pages.Day15.Params Pages.Day15.Model Pages.Day15.Msg
    , day16 : Upgraded Pages.Day16.Params Pages.Day16.Model Pages.Day16.Msg
    , day17 : Upgraded Pages.Day17.Params Pages.Day17.Model Pages.Day17.Msg
    , day18 : Upgraded Pages.Day18.Params Pages.Day18.Model Pages.Day18.Msg
    , day19 : Upgraded Pages.Day19.Params Pages.Day19.Model Pages.Day19.Msg
    , day2 : Upgraded Pages.Day2.Params Pages.Day2.Model Pages.Day2.Msg
    , day20 : Upgraded Pages.Day20.Params Pages.Day20.Model Pages.Day20.Msg
    , day21 : Upgraded Pages.Day21.Params Pages.Day21.Model Pages.Day21.Msg
    , day22 : Upgraded Pages.Day22.Params Pages.Day22.Model Pages.Day22.Msg
    , day23 : Upgraded Pages.Day23.Params Pages.Day23.Model Pages.Day23.Msg
    , day24 : Upgraded Pages.Day24.Params Pages.Day24.Model Pages.Day24.Msg
    , day25 : Upgraded Pages.Day25.Params Pages.Day25.Model Pages.Day25.Msg
    , day26 : Upgraded Pages.Day26.Params Pages.Day26.Model Pages.Day26.Msg
    , day27 : Upgraded Pages.Day27.Params Pages.Day27.Model Pages.Day27.Msg
    , day28 : Upgraded Pages.Day28.Params Pages.Day28.Model Pages.Day28.Msg
    , day29 : Upgraded Pages.Day29.Params Pages.Day29.Model Pages.Day29.Msg
    , day3 : Upgraded Pages.Day3.Params Pages.Day3.Model Pages.Day3.Msg
    , day30 : Upgraded Pages.Day30.Params Pages.Day30.Model Pages.Day30.Msg
    , day4 : Upgraded Pages.Day4.Params Pages.Day4.Model Pages.Day4.Msg
    , day5 : Upgraded Pages.Day5.Params Pages.Day5.Model Pages.Day5.Msg
    , day6 : Upgraded Pages.Day6.Params Pages.Day6.Model Pages.Day6.Msg
    , day7 : Upgraded Pages.Day7.Params Pages.Day7.Model Pages.Day7.Msg
    , day8 : Upgraded Pages.Day8.Params Pages.Day8.Model Pages.Day8.Msg
    , day9 : Upgraded Pages.Day9.Params Pages.Day9.Model Pages.Day9.Msg
    , notFound : Upgraded Pages.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , pageA : Upgraded Pages.PageA.Params Pages.PageA.Model Pages.PageA.Msg
    , pageB : Upgraded Pages.PageB.Params Pages.PageB.Model Pages.PageB.Msg
    }
pages =
    { top = Pages.Top.page |> upgrade Top__Model Top__Msg
    , day1 = Pages.Day1.page |> upgrade Day1__Model Day1__Msg
    , day10 = Pages.Day10.page |> upgrade Day10__Model Day10__Msg
    , day11 = Pages.Day11.page |> upgrade Day11__Model Day11__Msg
    , day12 = Pages.Day12.page |> upgrade Day12__Model Day12__Msg
    , day13 = Pages.Day13.page |> upgrade Day13__Model Day13__Msg
    , day14 = Pages.Day14.page |> upgrade Day14__Model Day14__Msg
    , day15 = Pages.Day15.page |> upgrade Day15__Model Day15__Msg
    , day16 = Pages.Day16.page |> upgrade Day16__Model Day16__Msg
    , day17 = Pages.Day17.page |> upgrade Day17__Model Day17__Msg
    , day18 = Pages.Day18.page |> upgrade Day18__Model Day18__Msg
    , day19 = Pages.Day19.page |> upgrade Day19__Model Day19__Msg
    , day2 = Pages.Day2.page |> upgrade Day2__Model Day2__Msg
    , day20 = Pages.Day20.page |> upgrade Day20__Model Day20__Msg
    , day21 = Pages.Day21.page |> upgrade Day21__Model Day21__Msg
    , day22 = Pages.Day22.page |> upgrade Day22__Model Day22__Msg
    , day23 = Pages.Day23.page |> upgrade Day23__Model Day23__Msg
    , day24 = Pages.Day24.page |> upgrade Day24__Model Day24__Msg
    , day25 = Pages.Day25.page |> upgrade Day25__Model Day25__Msg
    , day26 = Pages.Day26.page |> upgrade Day26__Model Day26__Msg
    , day27 = Pages.Day27.page |> upgrade Day27__Model Day27__Msg
    , day28 = Pages.Day28.page |> upgrade Day28__Model Day28__Msg
    , day29 = Pages.Day29.page |> upgrade Day29__Model Day29__Msg
    , day3 = Pages.Day3.page |> upgrade Day3__Model Day3__Msg
    , day30 = Pages.Day30.page |> upgrade Day30__Model Day30__Msg
    , day4 = Pages.Day4.page |> upgrade Day4__Model Day4__Msg
    , day5 = Pages.Day5.page |> upgrade Day5__Model Day5__Msg
    , day6 = Pages.Day6.page |> upgrade Day6__Model Day6__Msg
    , day7 = Pages.Day7.page |> upgrade Day7__Model Day7__Msg
    , day8 = Pages.Day8.page |> upgrade Day8__Model Day8__Msg
    , day9 = Pages.Day9.page |> upgrade Day9__Model Day9__Msg
    , notFound = Pages.NotFound.page |> upgrade NotFound__Model NotFound__Msg
    , pageA = Pages.PageA.page |> upgrade PageA__Model PageA__Msg
    , pageB = Pages.PageB.page |> upgrade PageB__Model PageB__Msg
    }