<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{
    function create(Request $request)
    {


        //Validate inputs
        $request->validate([
            'category_name' => 'required|regex:/[a-zA-Z0-9\s]+/|max:250',
        ]);


        $cats = explode(' ', $request->category_name);

        $sid = Auth::guard('store')->user()->id;
        $link_name = Auth::guard('store')->user()->store_id . '_' . implode('_', $cats);
        $categorys = DB::table('categories')->where('categories.store_id', $sid)
            ->where('categories.link_name', $link_name)->get();

        if (count($categorys) > 0) {

            return redirect()->back()->with('fail', 'The Category Already Exists in Your Store!');
        } else {

            $category = new Category();
            $category->name = $request->category_name;
            $category->link_name = Auth::guard('store')->user()->store_id . '_' . implode('_', $cats);
            $category->store_id = Auth::guard('store')->user()->id;

            $save = $category->save();

            if ($save) {
                return redirect()->back()->with('success', 'The Category is successfully registered.');
            } else {
                return redirect()->back()->with('fail', 'Something went Wrong, failed to register');
            }
        }
    }


    function destroy(Category $category)
    {
        $category->delete();
        return redirect("/store/categorys")->with('success', 'The Category is successfully Deleted');
    }

    function update(Category $category)
    {

        request()->validate([
            'category_name' => 'required|regex:/[a-zA-Z0-9\s]+/|max:50'
        ]);

        $cats = explode(' ', request()->category_name);
        $link_name = implode('-', $cats);

        $data = [
            'name' => request()->category_name,
            'link_name' => $link_name
        ];


        $save = $category->update($data);

        if ($save) {
            return redirect()->back()->with('success', 'The Category is successfully updated.');
        } else {
            return redirect()->back()->with('fail', 'Something went Wrong, failed to update');
        }
    }

    function update_show_cat(Category $category)
    {


        $tobe = 1;

        if ($category->show_cat == 1) {
            $tobe = 0;
        }

        $data = [
            'show_cat' => $tobe
        ];


        $save = $category->update($data);

        if ($save) {

            return response()->json(['res' => 'success']);
        } else {
            return response()->json(['res' => 'error']);
        }
    }

    function edit_category(Category $category)
    {
        // $category = DB::table('categorys')->where('id', '=', );
        return view('dashboard.store.edit_category', compact('category'));
    }


    function categorys(Request $request)
    {

        $store_id = Auth::guard('store')->user()->id;
        $categorys = DB::table('categories')->where('categories.store_id', $store_id)
            ->paginate(6);
        return view('dashboard.store.category', compact('categorys'))->with(request()->input('page'));
    }
}